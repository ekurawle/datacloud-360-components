public with sharing class DataCloudRelatedFieldController {

    @AuraEnabled(cacheable=true)
    public static List<SObject> getDrugRecords(String searchValue, String dmoName, String dmoSearchField, String dmoDisplayField) {

        // Safety check: Don't run if we are missing critical data
        if (String.isBlank(searchValue) || String.isBlank(dmoName) || String.isBlank(dmoSearchField)) {
            return new List<SObject>();
        }

        try {
            // We select the Search Field and the Display Field dynamically
            String fieldsToSelect = 'Id, ' + String.escapeSingleQuotes(dmoSearchField);

            if (String.isNotBlank(dmoDisplayField) && dmoDisplayField != dmoSearchField) {
                fieldsToSelect += ', ' + String.escapeSingleQuotes(dmoDisplayField);
            }

            // Query Data Cloud directly using the passed-in searchValue
            String dmoQuery = 'SELECT ' + fieldsToSelect +
                              ' FROM ' + String.escapeSingleQuotes(dmoName) +
                              ' WHERE ' + String.escapeSingleQuotes(dmoSearchField) + ' = :searchValue ' +
                              ' WITH SECURITY_ENFORCED LIMIT 1';

            return Database.query(dmoQuery);

        } catch (Exception e) {
            throw new AuraHandledException('Error fetching Data Cloud records: ' + e.getMessage());
        }
    }
}
