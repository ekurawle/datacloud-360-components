#!/bin/bash

###############################################################################
# Data Cloud 360 Components - Installation Script
#
# This script automates the deployment of Data Cloud 360 Components
# to your Salesforce org.
#
# Usage:
#   ./install.sh [ORG_ALIAS]
#
# If no org alias is provided, you'll be prompted to authenticate.
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║        Data Cloud 360 Components Installer                ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if SFDX CLI is installed
if ! command -v sfdx &> /dev/null; then
    echo -e "${RED}❌ Error: SFDX CLI is not installed.${NC}"
    echo ""
    echo "Please install SFDX CLI first:"
    echo "  https://developer.salesforce.com/tools/sfdxcli"
    exit 1
fi

echo -e "${GREEN}✅ SFDX CLI found${NC}"
sfdx --version
echo ""

# Get org alias
if [ -z "$1" ]; then
    echo -e "${YELLOW}No org alias provided.${NC}"
    echo ""
    echo "Would you like to:"
    echo "  1) Authenticate to a new org"
    echo "  2) Use an existing authenticated org"
    echo ""
    read -p "Enter your choice (1 or 2): " choice

    if [ "$choice" == "1" ]; then
        read -p "Enter an alias for your org: " ORG_ALIAS
        echo ""
        echo -e "${BLUE}🔐 Authenticating to Salesforce...${NC}"
        sfdx auth:web:login -a "$ORG_ALIAS"
    else
        echo ""
        echo "Available orgs:"
        sfdx force:org:list
        echo ""
        read -p "Enter the alias of the org to deploy to: " ORG_ALIAS
    fi
else
    ORG_ALIAS=$1
fi

echo ""
echo -e "${BLUE}🎯 Target Org: ${GREEN}${ORG_ALIAS}${NC}"
echo ""

# Verify org connection
echo -e "${BLUE}🔍 Verifying org connection...${NC}"
if ! sfdx force:org:display -u "$ORG_ALIAS" &> /dev/null; then
    echo -e "${RED}❌ Error: Cannot connect to org '${ORG_ALIAS}'${NC}"
    echo ""
    echo "Please authenticate first:"
    echo "  sfdx auth:web:login -a $ORG_ALIAS"
    exit 1
fi
echo -e "${GREEN}✅ Org connection verified${NC}"
echo ""

# Display org info
echo -e "${BLUE}📋 Org Information:${NC}"
sfdx force:org:display -u "$ORG_ALIAS" | grep -E "Username|Org Id|Instance Url"
echo ""

# Confirm deployment
read -p "$(echo -e ${YELLOW}⚠️  Proceed with deployment? [y/N]: ${NC})" confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo -e "${RED}❌ Deployment cancelled.${NC}"
    exit 0
fi

echo ""
echo -e "${BLUE}🚀 Starting deployment...${NC}"
echo ""

# Deploy components
echo -e "${BLUE}📦 Deploying components to ${ORG_ALIAS}...${NC}"
if sfdx force:source:deploy -p force-app -u "$ORG_ALIAS"; then
    echo -e "${GREEN}✅ Deployment successful!${NC}"
else
    echo -e "${RED}❌ Deployment failed!${NC}"
    echo ""
    echo "Check the error messages above and try again."
    exit 1
fi

echo ""

# Run tests
echo -e "${BLUE}🧪 Running Apex tests...${NC}"
if sfdx force:apex:test:run -n DataCloudRelatedFieldControllerTest -u "$ORG_ALIAS" -r human; then
    echo -e "${GREEN}✅ All tests passed!${NC}"
else
    echo -e "${YELLOW}⚠️  Some tests failed. Check output above.${NC}"
fi

echo ""

# Verify deployment
echo -e "${BLUE}🔍 Verifying components...${NC}"
echo ""

echo "Lightning Web Components:"
sfdx force:data:soql:query -q "SELECT DeveloperName, MasterLabel FROM LightningComponentBundle WHERE DeveloperName LIKE 'dataCloud%' ORDER BY DeveloperName" -u "$ORG_ALIAS" -r human

echo ""
echo "Apex Classes:"
sfdx force:data:soql:query -q "SELECT Name, Status FROM ApexClass WHERE Name LIKE 'DataCloudRelatedField%' ORDER BY Name" -u "$ORG_ALIAS" -r human

echo ""
echo -e "${GREEN}✅ Verification complete!${NC}"
echo ""

# Success message
echo -e "${GREEN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║        🎉 Installation Complete! 🎉                       ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${BLUE}📚 Next Steps:${NC}"
echo ""
echo "  1. Navigate to a Lightning record page"
echo "  2. Click the gear icon and select 'Edit Page'"
echo "  3. Find 'Data Cloud Multi-Column Card' in the components list"
echo "  4. Drag it onto your page"
echo "  5. Configure the properties in the right panel"
echo "  6. Save and activate the page"
echo ""
echo -e "${BLUE}📖 Documentation:${NC}"
echo "  • README: ./README_GITHUB.md"
echo "  • Deployment Guide: ./DEPLOYMENT_GUIDE.md"
echo "  • Configuration Examples: ./PACKAGE_SUMMARY.md"
echo ""
echo -e "${GREEN}🌟 Thank you for using Data Cloud 360 Components!${NC}"
echo ""
