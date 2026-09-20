# 🚀 How to Set Up Your QA GitHub Profile & Repositories

This guide walks you through publishing this profile and your testing showcase repositories to GitHub so recruiters and engineering managers can easily review your work.

---

## Option A: All-in-One Portfolio Repository (Easiest)

If you want to keep everything inside a single master portfolio repository:

1. **Initialize Git in this folder**:
   ```bash
   git init
   git add .
   git commit -m "feat: complete QA engineer portfolio showcase"
   ```
2. **Create a GitHub repository** named `qa-engineer-portfolio` on [GitHub](https://github.com/new).
3. **Push your code**:
   ```bash
   git branch -M main
   git remote add origin https://github.com/<YOUR_USERNAME>/qa-engineer-portfolio.git
   git push -u origin main
   ```
4. **Pin this repository** to the top of your GitHub profile page!

---

## Option B: Special GitHub Profile README (`<username>/<username>`) + Dedicated Pinned Repositories (Recommended for Maximum Impact)

GitHub allows you to create a special repository named exactly like your GitHub username. The `README.md` in that repository will automatically be rendered directly on your GitHub user profile page.

### Step 1: Create your Profile Repository
1. Go to [github.com/new](https://github.com/new).
2. Set **Repository name** to your exact GitHub username (e.g. if your username is `gio-qa`, name the repository `gio-qa`).
3. Make sure the repository is **Public** and check **"Add a README file"**.
4. Copy the contents of the root `README.md` file from this project into that repository's `README.md`.
5. Update:
   - `YOUR_GITHUB_USERNAME` with your actual GitHub username.
   - Your LinkedIn link and Email address.

### Step 2: Push Each Project as a Standalone Repository
Recruiters love seeing distinct repositories pinned on your profile. You can publish each of the four folders as its own repository:

1. **`01-manual-testing-project`** ➔ Create repo `ecommerce-manual-testing-showcase`
2. **`02-automation-testing-project`** ➔ Create repo `playwright-ts-automation-framework`
3. **`03-api-testing-project`** ➔ Create repo `postman-newman-api-testing-suite`
4. **`04-sql-for-qa`** ➔ Create repo `sql-data-validation-for-qa`

### Step 3: Pin Your Repositories
On your GitHub profile page (`https://github.com/<your-username>`), click **Customize your pins** and select the 4 repositories above.

Now any recruiter visiting your GitHub profile will immediately see your introduction, skills, stats, and 4 high-value QA projects!
