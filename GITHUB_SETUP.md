# 🚀 GitHub Setup Guide

This guide will walk you through uploading your Data Cloud 360 Components package to GitHub and making it easy for others to install.

---

## 📋 Prerequisites

- [ ] Git installed on your machine
- [ ] GitHub account created
- [ ] Package folder ready (`package-datacloud360/`)

---

## 🎯 Step-by-Step Instructions

### Step 1: Initialize Git Repository

Open Terminal/Command Prompt and navigate to your package folder:

```bash
cd /Users/ekurawle/Documents/VSCode/Thermo/Thermo/package-datacloud360

# Initialize git repository
git init

# Check status
git status
```

### Step 2: Create Initial Commit

```bash
# Add all files
git add .

# Create initial commit
git commit -m "Initial release v1.0.0 - Data Cloud 360 Components

- Add dataCloudMultiColumnCard LWC
- Add dataCloudRelatedField LWC
- Add DataCloudRelatedFieldController Apex class
- Add comprehensive documentation
- Add installation script
- Add GitHub Actions workflow"

# Verify commit
git log --oneline
```

### Step 3: Create GitHub Repository

#### Option A: Using GitHub Web Interface

1. Go to [GitHub](https://github.com)
2. Click the **"+"** icon in the top-right corner
3. Select **"New repository"**
4. Fill in the details:
   - **Repository name**: `datacloud-360-components`
   - **Description**: `Lightning Web Components for displaying Salesforce Data Cloud records in a configurable multi-column card`
   - **Visibility**: Choose **Public** (for open-source) or **Private**
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
5. Click **"Create repository"**

#### Option B: Using GitHub CLI (if installed)

```bash
# Create repository
gh repo create datacloud-360-components --public --source=. --description="Lightning Web Components for Salesforce Data Cloud"

# Push code
git push -u origin main
```

### Step 4: Connect Local Repository to GitHub

Copy the commands from your new GitHub repository page or use these (replace `ekurawle`):

```bash
# Add remote origin
git remote add origin https://github.com/ekurawle/datacloud-360-components.git

# Verify remote
git remote -v

# Push to GitHub (main or master branch)
git branch -M main
git push -u origin main
```

**Expected Output:**
```
Enumerating objects: XX, done.
Counting objects: 100% (XX/XX), done.
...
To https://github.com/ekurawle/datacloud-360-components.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

### Step 5: Update README with Your GitHub Username

After pushing, update these references in your GitHub repository:

1. Go to your repository on GitHub
2. Click on `README.md`
3. Click the pencil icon to edit
4. Replace all instances of `ekurawle` with your actual GitHub username
5. Commit changes

**Or update locally and push again:**

```bash
# Replace ekurawle in README.md
sed -i '' 's/ekurawle/your-actual-username/g' README.md
sed -i '' 's/ekurawle/your-actual-username/g' CHANGELOG.md
sed -i '' 's/ekurawle/your-actual-username/g' CONTRIBUTING.md

# Commit and push
git add README.md CHANGELOG.md CONTRIBUTING.md
git commit -m "Update GitHub username in documentation"
git push
```

### Step 6: Create a Release (Optional but Recommended)

1. Go to your repository on GitHub
2. Click **"Releases"** in the right sidebar
3. Click **"Create a new release"**
4. Fill in the details:
   - **Tag version**: `v1.0.0`
   - **Release title**: `v1.0.0 - Initial Release`
   - **Description**: Copy from `CHANGELOG.md`
5. Click **"Publish release"**

### Step 7: Set Up Repository Settings

#### Enable Issues
1. Go to **Settings** > **General**
2. Under **Features**, check **"Issues"**

#### Add Topics
1. Go to your repository main page
2. Click the gear icon next to "About"
3. Add topics:
   - `salesforce`
   - `lightning-web-components`
   - `data-cloud`
   - `lwc`
   - `salesforce-package`
   - `unmanaged-package`
   - `cdp`

#### Update Repository Description
1. Click the gear icon next to "About"
2. Add description: `Lightning Web Components for displaying Salesforce Data Cloud records in a configurable multi-column card`
3. Add website (if you have one)
4. Click **"Save changes"**

### Step 8: Create Installation Badge

Add a "Deploy to Salesforce" button by adding this to your README (already included):

```markdown
[![Deploy to Salesforce](https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png)](https://githubsfdeploy.herokuapp.com)
```

---

## 📦 Making It Easy for Others to Install

### Option 1: Direct Git Clone (Easiest)

Users can simply:

```bash
git clone https://github.com/ekurawle/datacloud-360-components.git
cd datacloud-360-components
./install.sh
```

The install script handles everything automatically!

### Option 2: Download ZIP

1. Your repository has a green **"Code"** button
2. Users click it and select **"Download ZIP"**
3. Extract and deploy using SFDX

### Option 3: Deploy Button

The "Deploy to Salesforce" button in your README allows one-click deployment (requires GitHub Deploy Tool setup).

### Option 4: Create Unmanaged Package (Most User-Friendly)

For non-technical users, create an unmanaged package:

1. Deploy to a packaging org
2. Create package in Setup
3. Upload package
4. Share the installation URL

Add this URL to your README:

```markdown
## 📦 Install Unmanaged Package

**Installation URL**: https://login.salesforce.com/packaging/installPackage.apexp?p0=PACKAGE_ID

Click the link above and follow the prompts to install in your org.
```

---

## 🎨 Enhance Your Repository

### Add Screenshots

1. Create a `screenshots/` folder
2. Add images of your component in action
3. Reference in README:

```markdown
![Component Screenshot](screenshots/component-example.png)
```

### Create a Wiki

1. Go to **Settings** > **General**
2. Enable **Wiki**
3. Add documentation pages:
   - Installation Guide
   - Configuration Examples
   - Troubleshooting
   - FAQs

### Set Up GitHub Pages (Optional)

1. Create a `docs/` folder
2. Add an `index.html` with documentation
3. Go to **Settings** > **Pages**
4. Enable GitHub Pages from the `docs/` folder

---

## 🔄 Keeping Your Repository Updated

### Create New Release

When you make changes:

```bash
# Make your changes
# ...

# Commit changes
git add .
git commit -m "Add new feature"

# Push to GitHub
git push

# Create new tag
git tag -a v1.1.0 -m "Version 1.1.0"
git push origin v1.1.0
```

Then create a new release on GitHub.

### Update CHANGELOG.md

Always document changes in `CHANGELOG.md` following the existing format.

---

## 📊 Monitor Your Repository

### Enable GitHub Actions

Your repository already includes a validation workflow (`.github/workflows/validate.yml`).

View workflow runs:
1. Go to **Actions** tab
2. See validation status for each push/PR

### Watch Repository Stats

Monitor:
- ⭐ Stars (users who like your package)
- 👁️ Watchers (users following updates)
- 🍴 Forks (users making their own versions)
- 📊 Traffic (visitor analytics)

---

## 🎯 Promote Your Package

### Share on Social Media

- LinkedIn: Post about your new package
- Twitter/X: Use hashtags like #Salesforce #LWC #DataCloud
- Reddit: r/salesforce subreddit

### List on AppExchange (Optional)

For wider distribution, consider listing on Salesforce AppExchange:
1. Convert to managed package
2. Pass security review
3. Submit to AppExchange

### Blog About It

Write a blog post explaining:
- Why you created it
- How to use it
- Use cases

---

## ✅ Checklist

After setup, verify:

- [ ] Repository created on GitHub
- [ ] All files pushed successfully
- [ ] README displays correctly
- [ ] Installation script is executable
- [ ] GitHub Actions workflow runs successfully
- [ ] Topics and description added
- [ ] Issues enabled
- [ ] License file present
- [ ] CONTRIBUTING.md available
- [ ] CHANGELOG.md updated
- [ ] Release created (optional)

---

## 🆘 Troubleshooting

### "Permission denied" when pushing

```bash
# Use personal access token or SSH key
# Generate token: GitHub Settings > Developer settings > Personal access tokens
git remote set-url origin https://ekurawle:YOUR_TOKEN@github.com/ekurawle/datacloud-360-components.git
```

### "Repository not found"

```bash
# Verify remote URL
git remote -v

# Update if needed
git remote set-url origin https://github.com/ekurawle/datacloud-360-components.git
```

### Files not showing on GitHub

```bash
# Check what was committed
git log --stat

# Force push if needed (careful!)
git push -f origin main
```

---

## 🎉 You're Done!

Your package is now on GitHub and ready for others to use!

**Next Steps:**
1. Share your repository URL
2. Monitor issues and PRs
3. Respond to community feedback
4. Release updates

**Your Repository URL:**
```
https://github.com/ekurawle/datacloud-360-components
```

---

**Need Help?**
- [GitHub Documentation](https://docs.github.com/)
- [Git Tutorial](https://git-scm.com/docs/gittutorial)
- [GitHub Community](https://github.community/)

**Happy Coding! 🚀**
