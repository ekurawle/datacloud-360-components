# ⚡ Quick Start Guide

## 🎯 Ready to Upload to GitHub? Follow These 4 Steps!

### Step 1️⃣: Create GitHub Repository

1. Go to [github.com/new](https://github.com/new)
2. Fill in:
   - **Name**: `datacloud-360-components`
   - **Description**: `Lightning Web Components for Salesforce Data Cloud`
   - **Visibility**: Public
   - **DON'T** check any initialization options
3. Click **"Create repository"**

### Step 2️⃣: Push Your Code

Copy/paste these commands (replace `ekurawle` with your GitHub username):

```bash
cd /Users/ekurawle/Documents/VSCode/Thermo/Thermo/package-datacloud360

# Connect to your new GitHub repo
git remote add origin https://github.com/ekurawle/datacloud-360-components.git

# Push your code
git push -u origin main
```

**That's it! Your package is now on GitHub! 🎉**

### Step 3️⃣: Update Repository Settings

On GitHub, click your repository, then:

1. Click gear icon next to "About"
2. Add these topics:
   - `salesforce`
   - `lightning-web-components`
   - `data-cloud`
   - `lwc`
   - `unmanaged-package`
3. Click **"Save changes"**

### Step 4️⃣: Update README

Replace `ekurawle` with your actual GitHub username:

```bash
# Update all references
sed -i '' 's/ekurawle/your-actual-username/g' README.md
sed -i '' 's/ekurawle/your-actual-username/g' CHANGELOG.md
sed -i '' 's/ekurawle/your-actual-username/g' CONTRIBUTING.md

# Push updates
git add .
git commit -m "Update GitHub username in docs"
git push
```

---

## 🚀 How Others Will Install Your Package

### Option 1: One-Command Install (Easiest!)

```bash
git clone https://github.com/ekurawle/datacloud-360-components.git
cd datacloud-360-components
./install.sh
```

The install script handles everything automatically!

### Option 2: Manual SFDX Deploy

```bash
git clone https://github.com/ekurawle/datacloud-360-components.git
cd datacloud-360-components
sfdx auth:web:login -a MyOrg
sfdx force:source:deploy -p force-app -u MyOrg
```

### Option 3: Download ZIP

Users can download your repo as ZIP and deploy using VS Code.

---

## 📦 What's Already Set Up

✅ **Git repository initialized**  
✅ **Initial commit created**  
✅ **24 files ready to push**  
✅ **Documentation complete**  
✅ **Installation script included**  
✅ **GitHub Actions workflow configured**  
✅ **MIT License added**  
✅ **.gitignore configured**  

---

## 🎨 Optional Enhancements

### Create a Release

1. Go to your repo on GitHub
2. Click **"Releases"** → **"Create a new release"**
3. Tag: `v1.0.0`
4. Title: `v1.0.0 - Initial Release`
5. Copy description from `CHANGELOG.md`
6. Click **"Publish release"**

### Add Screenshots

Create a `screenshots/` folder and add images:

```bash
mkdir screenshots
# Add your images
git add screenshots/
git commit -m "Add screenshots"
git push
```

Then reference in README:
```markdown
![Component Screenshot](screenshots/component-example.png)
```

---

## 🆘 Troubleshooting

### "Permission denied" error?

Use a Personal Access Token:

1. GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token with `repo` scope
3. Use token instead of password:

```bash
git remote set-url origin https://ekurawle:YOUR_TOKEN@github.com/ekurawle/datacloud-360-components.git
git push -u origin main
```

### "Repository not found"?

Double-check you created the repo on GitHub first, then verify the URL:

```bash
git remote -v
# Should show: origin  https://github.com/ekurawle/datacloud-360-components.git
```

---

## 📊 What's in Your Package

| File/Folder | Purpose |
|-------------|---------|
| `force-app/` | Salesforce components (LWC + Apex) |
| `README.md` | Main documentation |
| `install.sh` | Automated installation script |
| `DEPLOYMENT_GUIDE.md` | Detailed deployment instructions |
| `GITHUB_SETUP.md` | Complete GitHub upload guide |
| `CONTRIBUTING.md` | Contributor guidelines |
| `CHANGELOG.md` | Version history |
| `LICENSE` | MIT License |
| `.github/workflows/` | CI/CD automation |
| `manifest/package.xml` | Deployment manifest |

**Total**: 24 files, 2,802 lines of code & documentation

---

## 🎯 Quick Commands Reference

```bash
# See what's committed
git log --oneline

# Check status
git status

# Add remote (do this once)
git remote add origin https://github.com/ekurawle/datacloud-360-components.git

# Push to GitHub
git push -u origin main

# Make changes and push again
git add .
git commit -m "Your commit message"
git push
```

---

## ✅ Pre-Push Checklist

Before pushing to GitHub, verify:

- [ ] Git repository initialized (✅ Done!)
- [ ] Initial commit created (✅ Done!)
- [ ] GitHub repository created on github.com
- [ ] GitHub username to use: `_______________`
- [ ] Remote URL added
- [ ] Ready to push!

---

## 🌟 After Upload

Share your package:

1. **LinkedIn**: "Just published a Salesforce Data Cloud component package!"
2. **Twitter**: Use #Salesforce #LWC #DataCloud hashtags
3. **Reddit**: Post to r/salesforce
4. **Trailblazer Community**: Share in relevant groups

---

## 📞 Need More Help?

- **Detailed Guide**: See [GITHUB_SETUP.md](./GITHUB_SETUP.md)
- **GitHub Docs**: https://docs.github.com/
- **Git Tutorial**: https://git-scm.com/docs/gittutorial

---

**Your Package is Ready! 🚀**

Just create your GitHub repo and push. You're literally 2 commands away from publishing!

```bash
git remote add origin https://github.com/ekurawle/datacloud-360-components.git
git push -u origin main
```

**Good luck! 🎉**
