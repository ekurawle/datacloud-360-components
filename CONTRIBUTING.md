# Contributing to Data Cloud 360 Components

First off, thank you for considering contributing to Data Cloud 360 Components! 🎉

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)

---

## 🤝 Code of Conduct

This project follows the Salesforce Developer Community guidelines. Be respectful, inclusive, and constructive.

---

## 🎯 How Can I Contribute?

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](https://github.com/YOUR_USERNAME/datacloud-360-components/issues)
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Salesforce org edition and API version
   - Screenshots (if applicable)

### Suggesting Enhancements

1. Open an issue with the `enhancement` label
2. Describe the feature and why it would be useful
3. Include examples or mockups if possible

### Code Contributions

We welcome:
- Bug fixes
- New features
- Performance improvements
- Documentation improvements
- Test coverage improvements

---

## 🛠️ Development Setup

### Prerequisites

- SFDX CLI installed
- VS Code with Salesforce Extensions
- Git installed
- Salesforce Developer Org (or Scratch Org)

### Setup Steps

```bash
# 1. Fork the repository on GitHub

# 2. Clone your fork
git clone https://github.com/YOUR_USERNAME/datacloud-360-components.git
cd datacloud-360-components

# 3. Create a feature branch
git checkout -b feature/your-feature-name

# 4. Authenticate to your dev org
sfdx auth:web:login -a DevOrg

# 5. Deploy the package
sfdx force:source:deploy -p force-app -u DevOrg

# 6. Make your changes
# Edit files in force-app/main/default/

# 7. Test your changes
sfdx force:apex:test:run -n DataCloudRelatedFieldControllerTest -u DevOrg
```

---

## 📝 Pull Request Process

### Before Submitting

- [ ] Code follows our coding standards (see below)
- [ ] All tests pass
- [ ] New code has test coverage
- [ ] Documentation updated (if needed)
- [ ] Commits are clear and descriptive

### Submitting

1. Push your branch to your fork
2. Open a Pull Request against `main` branch
3. Fill out the PR template (will be provided)
4. Link related issues (if any)
5. Wait for review

### PR Title Format

```
[Type] Brief description

Types:
- [Feature] - New feature
- [Fix] - Bug fix
- [Docs] - Documentation only
- [Test] - Test improvements
- [Refactor] - Code refactoring
- [Perf] - Performance improvements
```

**Examples:**
- `[Feature] Add support for 4th column`
- `[Fix] Resolve null pointer in DataCloudRelatedField`
- `[Docs] Update README with new examples`

---

## 💻 Coding Standards

### Lightning Web Components

**JavaScript:**
```javascript
// ✅ Good
import { LightningElement, api } from 'lwc';

export default class MyComponent extends LightningElement {
    @api recordId;
    
    handleClick(event) {
        // Clear, descriptive names
        const buttonId = event.target.dataset.id;
        this.dispatchEvent(new CustomEvent('action', { 
            detail: { id: buttonId } 
        }));
    }
}

// ❌ Avoid
// Vague names, no comments on complex logic
export default class MyComp extends LightningElement {
    @api rid;
    h(e){this.dispatchEvent(new CustomEvent('a',{detail:e.target.dataset.i}))}
}
```

**HTML:**
```html
<!-- ✅ Good: Consistent indentation, clear structure -->
<template>
    <div class="slds-box">
        <lightning-card title="My Card">
            <div class="slds-p-around_medium">
                <p>{message}</p>
            </div>
        </lightning-card>
    </div>
</template>

<!-- ❌ Avoid: Inconsistent indentation, unclear structure -->
<template>
<div class="slds-box"><lightning-card title="My Card"><div class="slds-p-around_medium">
<p>{message}</p></div></lightning-card></div>
</template>
```

### Apex

```java
// ✅ Good
public with sharing class MyController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String searchTerm) {
        if (String.isBlank(searchTerm)) {
            return new List<Account>();
        }
        
        String query = 'SELECT Id, Name FROM Account ' +
                      'WHERE Name LIKE :searchTerm ' +
                      'WITH SECURITY_ENFORCED LIMIT 10';
        return Database.query(query);
    }
}

// ❌ Avoid
public class MC{
    @AuraEnabled
    public static List<Account> getA(String s){
        return Database.query('SELECT Id, Name FROM Account WHERE Name LIKE \'%'+s+'%\'');
    }
}
```

**Key Standards:**
- Always use `with sharing`
- Always use `WITH SECURITY_ENFORCED` in dynamic SOQL
- Use `@AuraEnabled(cacheable=true)` for read-only methods
- Validate all inputs
- Use descriptive variable names
- Include error handling

---

## 🧪 Testing Guidelines

### Apex Tests

All new Apex code must have test coverage:

```java
@IsTest
private class MyControllerTest {
    
    @TestSetup
    static void setupTestData() {
        // Create test data
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;
    }
    
    @IsTest
    static void testPositiveCase() {
        Test.startTest();
        List<Account> results = MyController.getAccounts('Test');
        Test.stopTest();
        
        System.assertEquals(1, results.size(), 'Expected 1 account');
    }
    
    @IsTest
    static void testNegativeCase() {
        Test.startTest();
        List<Account> results = MyController.getAccounts('');
        Test.stopTest();
        
        System.assertEquals(0, results.size(), 'Expected empty list for blank input');
    }
    
    @IsTest
    static void testExceptionHandling() {
        Boolean exceptionThrown = false;
        
        Test.startTest();
        try {
            MyController.methodThatThrows();
        } catch (Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();
        
        System.assert(exceptionThrown, 'Expected exception to be thrown');
    }
}
```

**Requirements:**
- ✅ Minimum 75% code coverage (aim for 90%+)
- ✅ Test positive cases
- ✅ Test negative cases (invalid inputs)
- ✅ Test exception handling
- ✅ Use `@TestSetup` for test data
- ✅ Use meaningful assertions with messages

### LWC Tests (Jest)

While not currently implemented, future Jest tests should follow:

```javascript
// myComponent.test.js
import { createElement } from 'lwc';
import MyComponent from 'c/myComponent';

describe('c-my-component', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('renders with correct title', () => {
        const element = createElement('c-my-component', {
            is: MyComponent
        });
        element.title = 'Test Title';
        document.body.appendChild(element);

        const title = element.shadowRoot.querySelector('h1');
        expect(title.textContent).toBe('Test Title');
    });
});
```

---

## 📦 Component Structure

When adding new components, follow this structure:

```
force-app/main/default/
├── lwc/
│   └── myNewComponent/
│       ├── myNewComponent.html
│       ├── myNewComponent.js
│       ├── myNewComponent.js-meta.xml
│       └── myNewComponent.css (optional)
└── classes/
    ├── MyNewController.cls
    ├── MyNewController.cls-meta.xml
    ├── MyNewControllerTest.cls
    └── MyNewControllerTest.cls-meta.xml
```

---

## 📖 Documentation Standards

### Code Comments

```javascript
/**
 * Fetches related Data Cloud records based on search criteria
 * @param {string} searchValue - Value to search for in DMO
 * @param {string} dmoName - Data Cloud object API name
 * @returns {Promise<Array>} Array of matching records
 */
async fetchRecords(searchValue, dmoName) {
    // Only comment complex logic, not obvious code
}
```

### README Updates

If your change affects usage, update:
- `README_GITHUB.md` - Main documentation
- `DEPLOYMENT_GUIDE.md` - If deployment steps change
- `PACKAGE_SUMMARY.md` - If components are added/removed

---

## 🏷️ Versioning

We use Semantic Versioning:

- **MAJOR** (1.0.0): Breaking changes
- **MINOR** (0.1.0): New features, backwards-compatible
- **PATCH** (0.0.1): Bug fixes, backwards-compatible

---

## 🎉 Recognition

Contributors will be recognized in:
- GitHub Contributors page
- Release notes
- ACKNOWLEDGMENTS section

---

## ❓ Questions?

- Open a [Discussion](https://github.com/YOUR_USERNAME/datacloud-360-components/discussions)
- Ask in [Salesforce Stack Exchange](https://salesforce.stackexchange.com/)
- Reach out in [Trailblazer Community](https://trailblazers.salesforce.com/)

---

**Thank you for contributing! 🚀**
