#!/usr/bin/env python3
"""
Automated SQL QA Test Runner
Executes database schema setup, seed data insertion, and all QA test query suites
against an in-memory SQLite database, producing formatted diagnostic reports.
"""

import sqlite3
import os
import re

def clean_query(raw_sql):
    """Remove single-line comments and empty lines to extract executable SQL"""
    lines = []
    for line in raw_sql.splitlines():
        trimmed = line.strip()
        if not trimmed.startswith("--") and trimmed:
            lines.append(line)
    return "\n".join(lines).strip()

def main():
    print("=" * 70)
    print("🔍 SWIFTSHOP QA BACKEND DATABASE VALIDATION RUNNER")
    print("=" * 70)

    # 1. Initialize In-Memory SQLite DB
    conn = sqlite3.connect(":memory:")
    cursor = conn.cursor()

    base_dir = os.path.dirname(os.path.abspath(__file__))
    schema_file = os.path.join(base_dir, "schema", "01-schema.sql")
    seed_file = os.path.join(base_dir, "schema", "02-seed-data.sql")

    # 2. Execute Schema
    print("\n[1/3] Initializing Database Schema...")
    with open(schema_file, "r") as f:
        cursor.executescript(f.read())
    print("✅ Schema created successfully.")

    # 3. Insert Seed Data
    print("\n[2/3] Seeding Test Data (including intentional anomalies)...")
    with open(seed_file, "r") as f:
        cursor.executescript(f.read())
    print("✅ Seed data inserted successfully.")

    # 4. Execute QA Test Suites
    print("\n[3/3] Executing QA Verification Suites...")
    queries_dir = os.path.join(base_dir, "queries")
    query_files = sorted([f for f in os.listdir(queries_dir) if f.endswith(".sql")])

    total_suites = len(query_files)
    total_anomalies_detected = 0

    for idx, q_file in enumerate(query_files, 1):
        q_path = os.path.join(queries_dir, q_file)
        print("\n" + "-" * 70)
        print(f"📁 Suite {idx}/{total_suites}: {q_file}")
        print("-" * 70)

        with open(q_path, "r") as f:
            content = f.read()

        raw_blocks = content.split(";")
        executable_queries = []
        for block in raw_blocks:
            cleaned = clean_query(block)
            if cleaned:
                executable_queries.append(cleaned)

        for sub_idx, query in enumerate(executable_queries, 1):
            try:
                cursor.execute(query)
                columns = [desc[0] for desc in cursor.description] if cursor.description else []
                rows = cursor.fetchall()

                print(f"\n  ▶ Test Query {idx}.{sub_idx}:")
                if rows:
                    total_anomalies_detected += len(rows)
                    print(f"    🚩 ANOMALIES FLAGGED ({len(rows)} record(s)):")
                    header_str = " | ".join(columns)
                    print(f"    {header_str}")
                    print("    " + "-" * min(len(header_str), 80))
                    for row in rows:
                        print(f"    {' | '.join(str(val) for val in row)}")
                else:
                    print("    ✅ PASSED: No integrity anomalies found.")
            except Exception as e:
                print(f"    ❌ Execution Error: {e}")

    print("\n" + "=" * 70)
    print("📊 QA DATABASE AUDIT COMPLETED")
    print(f"Total Suites Run: {total_suites}")
    print(f"Total Database Anomalies Caught: {total_anomalies_detected}")
    print("=" * 70)

    conn.close()

if __name__ == "__main__":
    main()
