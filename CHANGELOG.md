# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-07-01

### Added

#### Lightning Web Components
- **dataCloudMultiColumnCard**: Main component for displaying up to 3 Data Cloud related records
  - Configurable via Lightning App Builder
  - Supports Record, App, and Home pages
  - Dynamic show/hide behavior based on data validity
  - Responsive layout (mobile-friendly)
  
- **dataCloudRelatedField**: Child component for rendering individual columns
  - Loading states with spinner
  - Error handling and display
  - Custom "no data" messages
  - Status change event emission to parent

#### Apex Classes
- **DataCloudRelatedFieldController**: Server-side controller
  - `getDrugRecords()` method for querying Data Cloud objects
  - Dynamic SOQL generation
  - Input validation
  - Security enforced (WITH SECURITY_ENFORCED)
  - Cacheable for performance (@AuraEnabled(cacheable=true))
  
- **DataCloudRelatedFieldControllerTest**: Test class
  - 4 test methods covering all scenarios
  - ~90%+ code coverage
  - Tests for blank inputs, valid inputs, and exception handling

#### Configuration Features
- Support for up to 3 configurable columns
- Per-column properties (27+ configurable attributes):
  - Label, DMO Name, Search Fields, Display Fields
  - Invalid value filtering
  - Custom messages for missing data
  - Hide/show behavior
- Special routing for Unified Account DMO (CDP page support)

#### Documentation
- **README.md**: Comprehensive package overview
- **DEPLOYMENT_GUIDE.md**: Step-by-step deployment instructions
- **PACKAGE_SUMMARY.md**: Component inventory and relationships
- **CHECKLIST.md**: Pre/post deployment checklist
- **CONTRIBUTING.md**: Contribution guidelines
- **CHANGELOG.md**: This file
- **LICENSE**: MIT License

#### Automation
- **install.sh**: Automated installation script for UNIX/macOS
- **GitHub Actions**: CI/CD workflow for validation

#### Package Files
- **sfdx-project.json**: SFDX project configuration
- **manifest/package.xml**: Metadata manifest for deployment
- **.gitignore**: Git ignore patterns for Salesforce projects

### Technical Details
- API Version: 66.0
- Package Type: Unmanaged
- Salesforce Editions: Enterprise, Unlimited, Developer
- Dependencies: Data Cloud enabled in target org

### Security
- All Apex code uses `with sharing`
- All SOQL queries use `WITH SECURITY_ENFORCED`
- Input validation on all user inputs
- No hardcoded credentials or sensitive data

### Testing
- 100% test method pass rate
- ~90%+ Apex code coverage
- Manual testing completed on:
  - Record pages
  - App pages
  - Home pages
  - Mobile responsive layout

---

## [Unreleased]

### Planned Features
- Support for 4th and 5th columns
- Custom icon selection
- Dark mode support
- Export to CSV functionality
- Jest unit tests for LWC
- Scratch org support
- Package2 support for unlocked packages

### Under Consideration
- Inline editing of Data Cloud records
- Related list view (multiple records instead of single)
- Filter and sort options
- Custom styling options
- Integration with Flow
- Translation support (i18n)

---

## Version History

- **1.0.0** (2026-07-01): Initial release

---

## Upgrade Notes

### From Previous Versions
N/A - This is the initial release

### Future Upgrades
As an unmanaged package, components can be modified directly in your org after installation. However, this means:
- ⚠️ Future package updates will not automatically apply
- ⚠️ You'll need to manually apply changes from new releases
- ⚠️ Custom modifications may be overwritten if you redeploy

---

## Breaking Changes

### 1.0.0
None - Initial release

---

## Bug Fixes

### 1.0.0
None - Initial release

---

## Deprecations

### 1.0.0
None - Initial release

---

## Credits

### Original Implementation
This package is based on components originally developed for pharmaceutical industry use cases and has been generalized for broader Data Cloud integration scenarios.

### Contributors
- Initial package creation and documentation (2026-07-01)

---

## Support

- **Issues**: [GitHub Issues](https://github.com/ekurawle/datacloud-360-components/issues)
- **Discussions**: [GitHub Discussions](https://github.com/ekurawle/datacloud-360-components/discussions)
- **Community**: [Salesforce Stack Exchange](https://salesforce.stackexchange.com/)

---

**Note**: Replace `ekurawle` in URLs with your actual GitHub username after repository creation.
