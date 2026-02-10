/**
 * CreateMusubuFromApiUseCase のテストクラス
 *
 * @description API結果からの結ぶ法人情報作成機能をテストする。
 */
@IsTest
private class CreateMusubuFromApiUseCaseTest {

    @TestSetup
    static void setup() {
        // 既存の結ぶ法人情報を作成
        MusubuCompany__c existingCompany = new MusubuCompany__c(
            Name = '既存株式会社',
            CorporateNumber__c = '9876543210987'
        );
        insert existingCompany;
    }

    @IsTest
    static void testInvoke_CreateNew() {
        // 準備
        CreateMusubuFromApiUseCase.CompanyApiResponse apiResponse = createTestApiResponse();
        apiResponse.corporateNumber = '1234567890123'; // 新規の法人番号

        CreateMusubuFromApiUseCase useCase = new CreateMusubuFromApiUseCase();

        // 実行
        Test.startTest();
        CreateMusubuFromApiUseCase.CreateResult result = useCase.invoke(apiResponse);
        Test.stopTest();

        // 検証
        System.assertNotEquals(null, result.company, '結ぶ法人情報が返されること');
        System.assertEquals(true, result.isNewlyCreated, '新規作成されたこと');
        System.assertEquals('テスト株式会社', result.company.Name, '会社名が正しいこと');
    }

    @IsTest
    static void testInvoke_ReturnExisting() {
        // 準備
        CreateMusubuFromApiUseCase.CompanyApiResponse apiResponse = createTestApiResponse();
        apiResponse.corporateNumber = '9876543210987'; // 既存の法人番号

        CreateMusubuFromApiUseCase useCase = new CreateMusubuFromApiUseCase();

        // 実行
        Test.startTest();
        CreateMusubuFromApiUseCase.CreateResult result = useCase.invoke(apiResponse);
        Test.stopTest();

        // 検証
        System.assertNotEquals(null, result.company, '結ぶ法人情報が返されること');
        System.assertEquals(false, result.isNewlyCreated, '既存レコードが返されたこと');
        System.assertEquals('既存株式会社', result.company.Name, '既存の会社名であること');
    }

    @IsTest
    static void testInvoke_WithAllFields() {
        // 準備
        CreateMusubuFromApiUseCase.CompanyApiResponse apiResponse = new CreateMusubuFromApiUseCase.CompanyApiResponse();
        apiResponse.corporateNumber = '1111111111111';
        apiResponse.companyName = 'フルフィールド株式会社';
        apiResponse.address = '東京都渋谷区1-2-3';
        apiResponse.postalCode = '150-0001';
        apiResponse.prefecture = '東京都';
        apiResponse.city = '渋谷区';
        apiResponse.industry = 'IT';
        apiResponse.employeeCount = 100;
        apiResponse.capital = 10000000;
        apiResponse.establishedDate = Date.newInstance(2000, 1, 1);
        apiResponse.website = 'https://example.com';
        apiResponse.phone = '03-1234-5678';
        apiResponse.dataSource = 'Test API';

        CreateMusubuFromApiUseCase useCase = new CreateMusubuFromApiUseCase();

        // 実行
        Test.startTest();
        CreateMusubuFromApiUseCase.CreateResult result = useCase.invoke(apiResponse);
        Test.stopTest();

        // 検証
        System.assertEquals(true, result.isNewlyCreated, '新規作成されたこと');

        MusubuCompany__c company = [
            SELECT Id, Name, CorporateNumber__c, Address__c, PostalCode__c,
                   Prefecture__c, City__c, Industry__c, EmployeeCount__c,
                   Capital__c, EstablishedDate__c, Website__c, Phone__c, DataSource__c
            FROM MusubuCompany__c
            WHERE CorporateNumber__c = '1111111111111'
            LIMIT 1
        ];

        System.assertEquals('フルフィールド株式会社', company.Name);
        System.assertEquals('東京都渋谷区1-2-3', company.Address__c);
        System.assertEquals('150-0001', company.PostalCode__c);
        System.assertEquals('東京都', company.Prefecture__c);
        System.assertEquals('渋谷区', company.City__c);
        System.assertEquals('IT', company.Industry__c);
        System.assertEquals(100, company.EmployeeCount__c);
        System.assertEquals(10000000, company.Capital__c);
        System.assertEquals(Date.newInstance(2000, 1, 1), company.EstablishedDate__c);
        System.assertEquals('https://example.com', company.Website__c);
        System.assertEquals('03-1234-5678', company.Phone__c);
        System.assertEquals('Test API', company.DataSource__c);
    }

    @IsTest
    static void testInvokeForMultiple_Mixed() {
        // 準備
        List<CreateMusubuFromApiUseCase.CompanyApiResponse> responses = new List<CreateMusubuFromApiUseCase.CompanyApiResponse>();

        // 新規
        CreateMusubuFromApiUseCase.CompanyApiResponse newResponse1 = createTestApiResponse();
        newResponse1.corporateNumber = '1111111111111';
        newResponse1.companyName = '新規会社1';
        responses.add(newResponse1);

        // 既存
        CreateMusubuFromApiUseCase.CompanyApiResponse existingResponse = createTestApiResponse();
        existingResponse.corporateNumber = '9876543210987';
        existingResponse.companyName = '既存会社';
        responses.add(existingResponse);

        // 新規
        CreateMusubuFromApiUseCase.CompanyApiResponse newResponse2 = createTestApiResponse();
        newResponse2.corporateNumber = '2222222222222';
        newResponse2.companyName = '新規会社2';
        responses.add(newResponse2);

        CreateMusubuFromApiUseCase useCase = new CreateMusubuFromApiUseCase();

        // 実行
        Test.startTest();
        List<CreateMusubuFromApiUseCase.CreateResult> results = useCase.invokeForMultiple(responses);
        Test.stopTest();

        // 検証
        System.assertEquals(3, results.size(), '3件の結果が返ること');

        Integer newCount = 0;
        Integer existingCount = 0;
        for (CreateMusubuFromApiUseCase.CreateResult result : results) {
            if (result.isNewlyCreated) {
                newCount++;
            } else {
                existingCount++;
            }
        }
        System.assertEquals(2, newCount, '新規作成が2件であること');
        System.assertEquals(1, existingCount, '既存が1件であること');
    }

    @IsTest
    static void testInvokeForMultiple_AllNew() {
        // 準備
        List<CreateMusubuFromApiUseCase.CompanyApiResponse> responses = new List<CreateMusubuFromApiUseCase.CompanyApiResponse>();

        for (Integer i = 0; i < 5; i++) {
            CreateMusubuFromApiUseCase.CompanyApiResponse response = createTestApiResponse();
            response.corporateNumber = String.valueOf(1000000000000L + i);
            response.companyName = 'バルク会社' + i;
            responses.add(response);
        }

        CreateMusubuFromApiUseCase useCase = new CreateMusubuFromApiUseCase();

        // 実行
        Test.startTest();
        List<CreateMusubuFromApiUseCase.CreateResult> results = useCase.invokeForMultiple(responses);
        Test.stopTest();

        // 検証
        System.assertEquals(5, results.size(), '5件の結果が返ること');
        for (CreateMusubuFromApiUseCase.CreateResult result : results) {
            System.assertEquals(true, result.isNewlyCreated, '全て新規作成されたこと');
        }
    }

    @IsTest
    static void testInvokeForMultiple_AllExisting() {
        // 準備: 既存レコードを追加作成
        List<MusubuCompany__c> existingCompanies = new List<MusubuCompany__c>();
        for (Integer i = 0; i < 3; i++) {
            existingCompanies.add(new MusubuCompany__c(
                Name = '既存バルク会社' + i,
                CorporateNumber__c = String.valueOf(3000000000000L + i)
            ));
        }
        insert existingCompanies;

        List<CreateMusubuFromApiUseCase.CompanyApiResponse> responses = new List<CreateMusubuFromApiUseCase.CompanyApiResponse>();
        for (Integer i = 0; i < 3; i++) {
            CreateMusubuFromApiUseCase.CompanyApiResponse response = createTestApiResponse();
            response.corporateNumber = String.valueOf(3000000000000L + i);
            response.companyName = '既存バルク会社' + i;
            responses.add(response);
        }

        CreateMusubuFromApiUseCase useCase = new CreateMusubuFromApiUseCase();

        // 実行
        Test.startTest();
        List<CreateMusubuFromApiUseCase.CreateResult> results = useCase.invokeForMultiple(responses);
        Test.stopTest();

        // 検証
        System.assertEquals(3, results.size(), '3件の結果が返ること');
        for (CreateMusubuFromApiUseCase.CreateResult result : results) {
            System.assertEquals(false, result.isNewlyCreated, '全て既存レコードであること');
        }
    }

    @IsTest
    static void testCompanyApiResponse() {
        // CompanyApiResponse クラスのテスト
        CreateMusubuFromApiUseCase.CompanyApiResponse response = new CreateMusubuFromApiUseCase.CompanyApiResponse();
        response.corporateNumber = '1234567890123';
        response.companyName = 'Test Company';
        response.address = 'Test Address';
        response.postalCode = '100-0001';
        response.prefecture = 'Tokyo';
        response.city = 'Chiyoda';
        response.industry = 'IT';
        response.employeeCount = 50;
        response.capital = 1000000;
        response.establishedDate = Date.today();
        response.website = 'https://test.com';
        response.phone = '03-0000-0000';
        response.dataSource = 'API';

        System.assertEquals('1234567890123', response.corporateNumber);
        System.assertEquals('Test Company', response.companyName);
    }

    @IsTest
    static void testCreateResult() {
        // CreateResult クラスのテスト
        MusubuCompany__c company = new MusubuCompany__c(Name = 'Test');
        CreateMusubuFromApiUseCase.CreateResult result = new CreateMusubuFromApiUseCase.CreateResult(company, true);

        System.assertEquals(company, result.company);
        System.assertEquals(true, result.isNewlyCreated);
    }

    /**
     * テスト用 API レスポンスを作成
     */
    private static CreateMusubuFromApiUseCase.CompanyApiResponse createTestApiResponse() {
        CreateMusubuFromApiUseCase.CompanyApiResponse response = new CreateMusubuFromApiUseCase.CompanyApiResponse();
        response.companyName = 'テスト株式会社';
        response.corporateNumber = '0000000000000';
        response.address = '東京都千代田区1-1-1';
        response.prefecture = '東京都';
        response.city = '千代田区';
        response.dataSource = 'Test';
        return response;
    }
}