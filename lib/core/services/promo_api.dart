import 'package:http/http.dart' as http;
import 'package:test_peanut/core/models/promo_model.dart';
import 'package:xml/xml.dart';

class PromoAPI {
  Future<PromoModel?> getPromotionsAPI() async {
    try {
      var url = Uri.parse(
          'https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc');

      var headers = {
        'Content-Type': 'text/xml',
        'SOAPAction': 'http://tempuri.org/CabinetMicroService/GetCCPromo',
        // Add any other headers if needed
      };

      var body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://tempuri.org/">
   <soapenv:Header/>
   <soapenv:Body>
      <web:GetCCPromo>
         <web:lang>en</web:lang>
      </web:GetCCPromo>
   </soapenv:Body>
</soapenv:Envelope>
  ''';

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final jsonString = document
            .findAllElements('GetCCPromoResult')
            .first
            .text
            .replaceAll('False,', 'false,')
            .replaceAll('forex-images.instaforex.com', 'forex-images.ifxdb.com')
            .replaceAll('True,', 'True,');

        PromoModel promoModel = promoModelFromJson(jsonString);

        return promoModel;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
