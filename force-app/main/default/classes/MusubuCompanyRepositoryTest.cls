/**
 * MusubuCompanyRepository のテストクラス
 */
@IsTest
private class MusubuCompanyRepositoryTest {

    @TestSetup
    static void setup() {
        // 結ぶ法人情報を作成
        List<MusubuCompany__c> companies = new List<MusubuCompany__c>();
        companies.add(new MusubuCompany__c(
            Name = 'Test Company 1',
            CorporateNumber__c = '1111111111111',
            Industry__c = 'Technology',
            Address__c = '東京都渋谷区'
        ));
        companies.add(new MusubuCompany__c(
            Name = 'Test Company 2',
            CorporateNumber__c = '2222222222222',
            Industry__c = 'Finance',
            Address__c = '東京都新宿区'
        ));
        companies.add(new MusubuCompany__c(
            Name = 'Test Company 3',
            CorporateNumber__c = '3333333333333',
            Industry__c = 'Technology',
            Address__c = '大阪府大阪市'
        ));
        insert companies;
    }

    @IsTest
    static void testFindById() {
        // Given
        MusubuCompany__c testCompany = [SELECT Id FROM MusubuCompany__c WHERE Name = 'Test Company 1' LIMIT 1];
        MusubuCompanyRepository repo = new MusubuCompanyRepository();

        // When
        MusubuCompany__c result = repo.findCompanyById(testCompany.Id);

        // Then
        System.assertNotEquals(null, result, '結ぶ法人情報が取得できません');
        System.assertEquals(testCompany.Id, result.Id, 'IDが一致しません');
    }

    @IsTest
    static void testFindByIdReturnsNull() {
        // Given
        MusubuCompanyRepository repo = new MusubuCompanyRepository();
        Id fakeId = MusubuCompany__c.SObjectType.getDescribe().getKeyPrefix() + '000000000000';

        // When
        MusubuCompany__c result = repo.findCompanyById(fakeId);

        // Then
        System.assertEquals(null, result, '存在しないIDでnullが返されていません');
    }

    @IsTest
    static void testFindByIds() {
        // Given
        List<MusubuCompany__c> testCompanies = [SELECT Id FROM MusubuCompany__c];
        Set<Id> companyIds = new Set<Id>();
        for (MusubuCompany__c c : testCompanies) {
            companyIds.add(c.Id);
        }
        MusubuCompanyRepository repo = new MusubuCompanyRepository();

        // When
        List<MusubuCompany__c> results = repo.findCompaniesByIds(companyIds);

        // Then
        System.assertEquals(3, results.size(), '該当件数が一致しません');
    }

    @IsTest
    static void testFindByCorporateNumber() {
        // Given
        MusubuCompanyRepository repo = new MusubuCompanyRepository();

        // When
        MusubuCompany__c result = repo.findByCorporateNumber('1111111111111');

        // Then
        System.assertNotEquals(null, result, '法人番号で結ぶ法人情報が取得できません');
        System.assertEquals('Test Company 1', result.Name, '会社名が一致しません');
    }

    @IsTest
    static void testFindByCorporateNumberReturnsNull() {
        // Given
        MusubuCompanyRepository repo = new MusubuCompanyRepository();

        // When
        MusubuCompany__c result = repo.findByCorporateNumber('9999999999999');

        // Then
        System.assertEquals(null, result, '存在しない法人番号でnullが返されていません');
    }

    @IsTest
    static void testFindByCorporateNumbers() {
        // Given
        Set<String> corporateNumbers = new Set<String>{ '1111111111111', '2222222222222' };
        MusubuCompanyRepository repo = new MusubuCompanyRepository();

        // When
        List<MusubuCompany__c> results = repo.findByCorporateNumbers(corporateNumbers);

        // Then
        System.assertEquals(2, results.size(), '複数法人番号での検索結果が一致しません');
    }

    @IsTest
    static void testFindByCorporateNumbersAsMap() {
        // Given
        Set<String> corporateNumbers = new Set<String>{ '1111111111111', '2222222222222', '3333333333333' };
        MusubuCompanyRepository repo = new MusubuCompanyRepository();

        // When
        Map<String, MusubuCompany__c> resultMap = repo.findByCorporateNumbersAsMap(corporateNumbers);

        // Then
        System.assertEquals(3, resultMap.size(), 'Map のサイズが一致しません');
        System.assertEquals('Test Company 1', resultMap.get('1111111111111').Name, '法人番号1の会社名が一致しません');
        System.assertEquals('Test Company 2', resultMap.get('2222222222222').Name, '法人番号2の会社名が一致しません');
        System.assertEquals('Test Company 3', resultMap.get('3333333333333').Name, '法人番号3の会社名が一致しません');
    }

    @IsTest
    static void testFindByIdWithAllFields() {
        // Given
        MusubuCompany__c testCompany = [SELECT Id FROM MusubuCompany__c WHERE Name = 'Test Company 1' LIMIT 1];
        MusubuCompanyRepository repo = new MusubuCompanyRepository();

        // When
        MusubuCompany__c result = repo.findCompanyByIdWithAllFields(testCompany.Id);

        // Then
        System.assertNotEquals(null, result, '結ぶ法人情報が取得できません');
        System.assertEquals('Test Company 1', result.Name, '会社名が一致しません');
        System.assertEquals('1111111111111', result.CorporateNumber__c, '法人番号が一致しません');
        System.assertEquals('Technology', result.Industry__c, '業種が一致しません');
        System.assertEquals('東京都渋谷区', result.Address__c, '住所が一致しません');
    }
}