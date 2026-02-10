/**
 * OpenAI Cloud Run API サービス
 *
 * @description 法人情報検索 API を呼び出すサービスクラス。
 *              Named Credential を使用して認証を行う。
 */
public with sharing class OpenAICloudRunService {

    private static final String NAMED_CREDENTIAL = 'callout:OpenAICloudRunLogin';
    private static final String SEARCH_ENDPOINT = '/api/v1/company/search';
    private static final Integer TIMEOUT_MS = 30000;

    /**
     * 法人情報を検索する
     *
     * @param request 検索リクエスト
     * @return 検索結果
     */
    public CompanySearchResponse searchCompany(CompanySearchRequest request) {
        Logger.info('OpenAICloudRunService.searchCompany を開始します - companyName: ' + request.companyName + ', corporateNumber: ' + request.corporateNumber);

        try {
            // 1. リクエストを作成
            HttpRequest httpRequest = buildSearchRequest(request);

            // 2. HTTP コールアウト
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);

            // 3. レスポンスを処理
            return handleSearchResponse(httpResponse);

        } catch (CalloutException e) {
            Logger.error('API コールアウトに失敗しました', e);
            throw new OpenAICloudRunException('API 呼び出しに失敗しました', e);

        } finally {
            Logger.saveLog();
        }
    }

    /**
     * 検索リクエストを構築する
     *
     * @param request 検索リクエスト
     * @return HTTP リクエスト
     */
    private HttpRequest buildSearchRequest(CompanySearchRequest request) {
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint(NAMED_CREDENTIAL + SEARCH_ENDPOINT);
        httpRequest.setMethod('POST');
        httpRequest.setHeader('Content-Type', 'application/json');
        httpRequest.setTimeout(TIMEOUT_MS);

        Map<String, Object> requestBody = new Map<String, Object>();

        if (String.isNotBlank(request.companyName)) {
            requestBody.put('company_name', request.companyName);
        }
        if (String.isNotBlank(request.corporateNumber)) {
            requestBody.put('corporate_number', request.corporateNumber);
        }
        if (String.isNotBlank(request.phone)) {
            requestBody.put('phone', request.phone);
        }
        if (String.isNotBlank(request.website)) {
            requestBody.put('website', request.website);
        }
        if (String.isNotBlank(request.address)) {
            requestBody.put('address', request.address);
        }

        httpRequest.setBody(JSON.serialize(requestBody));

        Logger.debug('API リクエストを構築しました - endpoint: ' + NAMED_CREDENTIAL + SEARCH_ENDPOINT);

        return httpRequest;
    }

    /**
     * 検索レスポンスを処理する
     *
     * @param httpResponse HTTP レスポンス
     * @return 検索結果
     */
    private CompanySearchResponse handleSearchResponse(HttpResponse httpResponse) {
        Integer statusCode = httpResponse.getStatusCode();
        String responseBody = httpResponse.getBody();

        Logger.debug('API レスポンスを受信しました - statusCode: ' + statusCode);

        // エラーレスポンスの処理
        if (statusCode != 200) {
            Logger.warn('API がエラーを返しました - statusCode: ' + statusCode);

            if (statusCode == 404) {
                // 見つからない場合は空のレスポンスを返す
                CompanySearchResponse notFoundResponse = new CompanySearchResponse();
                notFoundResponse.found = false;
                return notFoundResponse;
            }

            throw new OpenAICloudRunException('API エラー: ' + statusCode);
        }

        // レスポンスをパース
        try {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(responseBody);

            CompanySearchResponse response = new CompanySearchResponse();
            response.found = true;
            response.corporateNumber = (String) responseMap.get('corporate_number');
            response.companyName = (String) responseMap.get('company_name');
            response.address = (String) responseMap.get('address');
            response.postalCode = (String) responseMap.get('postal_code');
            response.prefecture = (String) responseMap.get('prefecture');
            response.city = (String) responseMap.get('city');
            response.industry = (String) responseMap.get('industry');
            response.website = (String) responseMap.get('website');
            response.phone = (String) responseMap.get('phone');

            Object employeeCountObj = responseMap.get('employee_count');
            if (employeeCountObj != null) {
                response.employeeCount = Integer.valueOf(employeeCountObj);
            }

            Object capitalObj = responseMap.get('capital');
            if (capitalObj != null) {
                response.capital = Decimal.valueOf(String.valueOf(capitalObj));
            }

            String establishedDateStr = (String) responseMap.get('established_date');
            if (String.isNotBlank(establishedDateStr)) {
                response.establishedDate = Date.valueOf(establishedDateStr);
            }

            Logger.info('法人情報を取得しました - corporateNumber: ' + response.corporateNumber + ', companyName: ' + response.companyName);

            return response;

        } catch (Exception e) {
            Logger.error('レスポンスのパースに失敗しました', e);
            throw new OpenAICloudRunException('レスポンスのパースに失敗しました', e);
        }
    }

    /**
     * 検索リクエスト
     */
    public class CompanySearchRequest {
        public String companyName;
        public String corporateNumber;
        public String phone;
        public String website;
        public String address;
    }

    /**
     * 検索レスポンス
     */
    public class CompanySearchResponse {
        public Boolean found;
        public String corporateNumber;
        public String companyName;
        public String address;
        public String postalCode;
        public String prefecture;
        public String city;
        public String industry;
        public Integer employeeCount;
        public Decimal capital;
        public Date establishedDate;
        public String website;
        public String phone;
    }

    /**
     * API エラー例外
     */
    public class OpenAICloudRunException extends Exception {}
}