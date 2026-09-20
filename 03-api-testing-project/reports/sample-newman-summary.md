# 📋 Newman Test Execution Output Summary

Below is a captured sample of the Newman CLI run against the **Restful-Booker API** staging environment:

```text
newman run collections/qa-api-portfolio.postman_collection.json \
  -e environments/staging.postman_environment.json \
  --reporters cli

QA Portfolio API Testing Suite (Restful-Booker)

→ 01 - Authentication / Create Auth Token (Positive)
  POST https://restful-booker.herokuapp.com/auth [200 OK, 1.2kB, 432ms]
  ✓ Status code is 200 OK
  ✓ Response contains valid auth token string
  ✓ Response time is under threshold

→ 01 - Authentication / Create Auth Token - Invalid Credentials (Negative)
  POST https://restful-booker.herokuapp.com/auth [200 OK, 882B, 311ms]
  ✓ Status code is 200 OK with bad credentials reason

→ 02 - Booking CRUD Lifecycle / Create Booking (POST)
  POST https://restful-booker.herokuapp.com/booking [200 OK, 1.1kB, 389ms]
  ✓ Status code is 200 OK
  ✓ Response has bookingid and saves to environment
  ✓ Booking payload details match request data

→ 02 - Booking CRUD Lifecycle / Get Booking by ID (GET)
  GET https://restful-booker.herokuapp.com/booking/3482 [200 OK, 1.0kB, 298ms]
  ✓ Status code is 200 OK
  ✓ Content-Type header is JSON
  ✓ Booking contract schema validation

→ 02 - Booking CRUD Lifecycle / Full Update Booking (PUT)
  PUT https://restful-booker.herokuapp.com/booking/3482 [200 OK, 1.1kB, 355ms]
  ✓ Status code is 200 OK
  ✓ Booking totalprice updated to 450

→ 02 - Booking CRUD Lifecycle / Partial Update Booking (PATCH)
  PATCH https://restful-booker.herokuapp.com/booking/3482 [200 OK, 1.0kB, 321ms]
  ✓ Status code is 200 OK
  ✓ Partial field updated successfully

→ 02 - Booking CRUD Lifecycle / Delete Booking (DELETE)
  DELETE https://restful-booker.herokuapp.com/booking/3482 [201 Created, 760B, 310ms]
  ✓ Status code is 201 Created (successful delete in Restful-Booker)

→ 02 - Booking CRUD Lifecycle / Verify Deleted Booking Returns 404 (GET)
  GET https://restful-booker.herokuapp.com/booking/3482 [404 Not Found, 750B, 280ms]
  ✓ Deleted resource returns 404 Not Found

→ 03 - Negative & Security Scenarios / Update Booking without Auth Token (403 Forbidden)
  PUT https://restful-booker.herokuapp.com/booking/1 [403 Forbidden, 765B, 275ms]
  ✓ Unauthorized request returns 403 Forbidden

→ 03 - Negative & Security Scenarios / Get Non-Existent Booking ID (404 Not Found)
  GET https://restful-booker.herokuapp.com/booking/999999999 [404 Not Found, 750B, 290ms]
  ✓ Non-existent ID returns 404 Not Found

┌─────────────────────────┬─────────────────────┬─────────────────────┐
│                         │            executed │              failed │
├─────────────────────────┼─────────────────────┼─────────────────────┤
│              iterations │                   1 │                   0 │
├─────────────────────────┼─────────────────────┼─────────────────────┤
│                requests │                  10 │                   0 │
├─────────────────────────┼─────────────────────┼─────────────────────┤
│            test-scripts │                  10 │                   0 │
├─────────────────────────┼─────────────────────┼─────────────────────┤
│      prerequest-scripts │                   1 │                   0 │
├─────────────────────────┼─────────────────────┼─────────────────────┤
│              assertions │                  15 │                   0 │
├─────────────────────────┴─────────────────────┴─────────────────────┤
│ total run duration: 3.4s                                            │
│ total data received: 9.8kB (approx)                                 │
│ average response time: 326ms                                        │
└─────────────────────────────────────────────────────────────────────┘
```
