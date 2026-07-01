@IsTest
private class DataCloudRelatedFieldControllerTest {

    @TestSetup
    static void setupTestData() {
        // Swapped AccountNumber for Phone, which is almost universally accessible by default FLS
        Account testAcc = new Account(
            Name = 'Test Drug Alpha',
            Phone = '555-0100'
        );
        insert testAcc;
    }

    @IsTest
    static void testGetDrugRecords_BlankInputs() {
        Test.startTest();
        List<SObject> resultsMissingSearch = DataCloudRelatedFieldController.getDrugRecords('', 'Account', 'Name', '');
        List<SObject> resultsMissingDmo = DataCloudRelatedFieldController.getDrugRecords('Test Drug Alpha', '', 'Name', '');
        List<SObject> resultsMissingField = DataCloudRelatedFieldController.getDrugRecords('Test Drug Alpha', 'Account', '', '');
        Test.stopTest();

        System.assertEquals(0, resultsMissingSearch.size(), 'Expected an empty list when searchValue is blank.');
        System.assertEquals(0, resultsMissingDmo.size(), 'Expected an empty list when dmoName is blank.');
        System.assertEquals(0, resultsMissingField.size(), 'Expected an empty list when dmoSearchField is blank.');
    }

    @IsTest
    static void testGetDrugRecords_ValidInputs_NoDisplayField() {
        Test.startTest();
        List<SObject> results = DataCloudRelatedFieldController.getDrugRecords('Test Drug Alpha', 'Account', 'Name', '');
        Test.stopTest();

        System.assertEquals(1, results.size(), 'Expected exactly 1 record to be returned.');
        System.assertEquals('Test Drug Alpha', (String)results[0].get('Name'), 'Expected the retrieved Name to match the query parameter.');
    }

    @IsTest
    static void testGetDrugRecords_ValidInputs_WithDisplayField() {
        Test.startTest();
        // Request 'Phone' as the display field instead of AccountNumber
        List<SObject> results = DataCloudRelatedFieldController.getDrugRecords('Test Drug Alpha', 'Account', 'Name', 'Phone');
        Test.stopTest();

        System.assertEquals(1, results.size(), 'Expected exactly 1 record to be returned.');
        System.assertEquals('Test Drug Alpha', (String)results[0].get('Name'), 'Expected the retrieved Name to match.');
        System.assertEquals('555-0100', (String)results[0].get('Phone'), 'Expected the distinct display field to be queried and populated.');
    }

    @IsTest
    static void testGetDrugRecords_ExceptionHandling() {
        Boolean exceptionThrown = false;

        Test.startTest();
        try {
            DataCloudRelatedFieldController.getDrugRecords('Test', 'NonExistentObject__c', 'Name', '');
        } catch (AuraHandledException e) {
            exceptionThrown = true;
            System.assert(e.getMessage().contains('Script-thrown exception'), 'Expected AuraHandledException wrapper.');
        }
        Test.stopTest();

        System.assert(exceptionThrown, 'Expected an AuraHandledException to be thrown due to a bad SOQL query.');
    }
}
