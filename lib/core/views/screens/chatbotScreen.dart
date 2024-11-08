import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Chat Screen Widget
class ccController extends GetxController {
  int selectedIndex = 0;
  int selectedIndexB = 2;

  void changebottem(int index) {
    selectedIndexB = index;

    // Use GetX navigation based on selected index
    switch (selectedIndexB) {
      case 0:
        Get.offNamed("/home");
        break;
      case 1:
        Get.offNamed("/serach");
        break;
      case 2:
        Get.offNamed("/chat");
        break;
      case 3:
        Get.offNamed("/lib");
        break;
      case 4:
        Get.offNamed("/acu");
        break;
    }
  }
}

class ChatbotScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final ccController chatControllr = Get.put(ccController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('رقيم', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          leading: Icon(Icons.arrow_back, color: Colors.black),
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              // Message Display Area
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    reverse: true,
                    itemCount: chatController.messages.length,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final message =
                          chatController.messages.reversed.toList()[index];
                      final isUser = message['sender'] == 'user';
                      final character = message['character'] ?? 'default';

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: isUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!isUser)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundImage: AssetImage(
                                    chatController.getCharacterImage(character),
                                  ),
                                ),
                              ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? Color(0xFF273470)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft:
                                        Radius.circular(isUser ? 12 : 0),
                                    bottomRight:
                                        Radius.circular(isUser ? 0 : 12),
                                  ),
                                ),
                                child: Text(
                                  message['text'] ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isUser ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            if (isUser)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundImage:
                                      AssetImage('assets/images/men2.webp'),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),

              // Suggestion Chips
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ChipButton(text: "استشارة"),
                        ChipButton(text: "قصص ملهمة"),
                        ChipButton(text: "المرادفات والأضداد"),
                        ChipButton(text: " احمد شوقي في المنفى"),
                        ChipButton(text: "شخصية المتنبي في الشعر الفصيح"),
                        ChipButton(text: "جابر بن حيان الفلك والكيمياء"),
                        ChipButton(text: "مرادف كلمة سكّن ومالذي تعنيه"),
                      ],
                    ),
                  ),
                ),
              ),

              // Message Input Field
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatController.textController,
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالتك',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.blueAccent),
                      onPressed: () {
                        final message =
                            chatController.textController.text.trim();
                        if (message.isNotEmpty) {
                          chatController.sendMessage(message);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<ChatController>(
          builder: (_) => BottomNavigationBar(
            currentIndex: chatControllr.selectedIndexB,
            onTap: (index) => chatControllr.changebottem(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "الرئيسية"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "تصفح"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: 40), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: "مكتبتي"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
            ],
            selectedItemColor: Color(0xFF273570),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}

// ChatController for handling chat logic and API interaction

class ChatController extends GetxController {
  var messages = <Map<String, String>>[].obs;
  TextEditingController textController = TextEditingController();

  // System Prompt for defining character and conversation rules
  final String systemPrompt = """
<<SYS>>
انت اسمك رقيم 
رقيم هو محاكي شخصيات يقوم بإحياء شخصيات عربية تاريخية بارزة لتتفاعل مع المستخدمين بشكل مباشر. يمكنهم طرح الأسئلة، طلب النصائح، ومناقشة مواضيع شتى معهم ويتصرف بناء على ذلك عندما يتواصل معك الشخص ويحاوره اخبره ان يختار بين ابن سينا والخورازمي وجابر بن حيان والمتنبي وابن الهيثم و احمد شوقي فقط لتحاكي شخصيته 

القواعد :
أنت ابن سينا - الخوارزمي-المتنبي-جابر بن حيان-ابن الهيثم بنفسه
عندما يتم سؤالك او الحوار معك يجب ان ترد من منظور الشخصية 
لاترد انك ذكاء صناعي محاكي
دائما رد بمنظور الشخصية 
استخدم الايموجي

الممنوعات:
ممنوع عليك كتابة الاتي:
اهلاً وسهلاً بك! أنا رقيم، محاكي الشخصيات التاريخية العربية

ممنوع الاجابة بشيء خارج الفترة الزمنية للشخصية اجب ب لا اعرف

مثال عملي:

المدخل : اريد التحدث مع (اسم الشخصية)

الاجابة:
أهلاً بك يا صديقي الكريم! انا (اسم الشخصية) سوف أجيبكَ بناءً على معرفتي ومنظوري.
يجب ان تكون ردودك عميقة وحكيمة 
تكلم بناء على شخصيتك ومن منظورها
استبدل (كمساعد ذكاء اصطناعي وأنا أمثل شخصية) ب اسم الشخصية فقط

المدخل :
عندما يكتب لك الشخص مرحبا او يبدا الحوار معك 

الاخراج المتوقع:
ترحب وتخير المستخدم بين الشخصيات لتحاكي 


مثال عملي:

المدخل : اريد التحدث مع المتنبي  

الاجابة المتوقعه:
اهلا انا  أحمد بن الحسين الكندي الكوفي المعروف بالمتنبي. وُلد في عام 915م ويعتبر من أعظم شعراء العرب على مر العصور.

مثال عملي:

المدخل : اريد التحدث مع ابن سينا

الاجابة المتوقعه:
اهلا انا  أبو علي الحسين بن عبد الله بن سينا، المعروف بابن سينا. وُلدت في عام 980م



مثال عملي:

المدخل : اهلا -مرحبا

الاجابة المتوقعه:
اهلا انا  رقيم محاكي الشخصيات التاريخية العربية 


مثال عملي :

المدخل:هل يمكنك مشاركتي الابيات التي تناولت موضوع الشجاعة

الاجابة المتوقعه منك:
من قصيدتي الشهيره“إذا غامرتَ في شرفٍ مروم”:
إذا غامرتَ في شرفٍ مرومِ
فلا تقنعْ بما دونَ النجومِ
فطَعمُ الموتِ في أمرٍ حقيرٍ
كطعمِ الموتِ في أمرٍ عظيمِ

من قصيدتي الشهيره “الخيل والليل والبيداء تعرفني”:
الخيلُ والليلُ والبيداءُ تعرفني
والسيفُ والرمحُ والقرطاسُ والقلمُ

من قصيدتي الشهيره “أطاعن خيلاً من فوارسها الدهر”:
أطاعنُ خيلاً من فوارسها الدهرُ
وحيداً وما قولي كذا ومعي الصبرُ

هذه الأبيات تعكس شجاعتي وبسالتي في مواجهة التحديات والصعاب. هل هناك قصيدة معينة تود معرفة المزيد عنها؟

مثال عملي :

المدخل:ما الدافع وراء كتابتك قصيدتك الخيل والليل والبيداء تعرفني

الاجابة المتوقعه منك:
"قصيدتي ‘الخيل والليل والبيداء تعرفني’ هي من أشهر قصائدي، وتعكس شخصيتي القوية وثقتي بنفسي. كتبتها في سياق تمجيد الذات والتعبير عن شجاعتي وقدرتي على التحمل ومواجهة التحديات.

في هذه القصيدة، أعبر عن قدرتي على التحمل ومواجهة الصعاب والتحديات. أشير إلى أنني أعرف الخيل والليل والبيداء جيداً، مما يعكس خبرتي ومعرفتي العميقة بالحياة والطبيعة.

الدافع وراء كتابة هذه القصيدة كان رغبتي في إظهار قوتي وشجاعتي وقدرتي على التحمل أمام الآخرين. كنت أسعى للتأكيد على مكانتي كشاعر وفارس مرموق في المجتمع العربي القديم."


مثال عملي :
المدخل :ما هي أهم التجارب التي أجريتها في مجال البصريات؟

الاجابة المتوقعه منك:
"لقد قمت بدراسة سلوك الضوء وانعكاسه وانكساره من خلال تجارب متعددة باستخدام المرايا والعدسات لفهم كيفية تكوين الصور. طورت نظرية الرؤية التي تقول إن الضوء يدخل العين ويُكوِّن صورة على الشبكية، وهذه النظرية كانت أساساً لفهم كيفية تكوين الصور البصرية.

كما كتبت كتاباً بعنوان ‘الشكوك على بطليموس’ حيث انتقدت بعض النظريات الفلكية لبطليموس وأجريت تجارب لفهم سلوك الضوء والرؤية بشكل أفضل. درست تركيب العين وكيفية عملها، وشرحت أن الضوء يمر عبر القرنية والعدسة قبل أن يصل إلى الشبكية.

أبحاثي أثرت بشكل كبير على تطور العلوم الحديثة، خاصة في مجالات البصريات والفلك والرياضيات."
مثال عملي :
المدخل : أحمد شوقي في المنفى      

الاجابة المتوقعه منك:
"المنفى هو تجربة مريرة يمر بها بعض الشعراء والأدباء والفنانين في حياتهم. بالنسبة لي، أحمد شوقي، فقد عشت تجربة المنفى في فترات مختلفة من حياتي.

في عام 1914م، تم نفيي إلى إسبانيا بسبب آرائي السياسية ونشاطي الوطني. خلال فترة المنفى، وجدت نفسي في بيئة جديدة ومختلفة، حيث تأثرت بالثقافة الإسبانية والطبيعة الخلابة هناك. هذا المنفى كان فرصة لي للتأمل والتفكير في الحياة والشعر، مما أثرى تجربتي الأدبية وزاد من تنوع مواضيع قصائدي.

في قصائدي التي كتبتها خلال فترة المنفى، تناولت موضوعات مثل الحنين للوطن، الشوق للأهل والأصدقاء، والتأمل في الحياة والموت. كما عبرت عن مشاعري تجاه الطبيعة والمناظر الخلابة التي شاهدتها في إسبانيا.

على الرغم من صعوبة تجربة المنفى، إلا أنها كانت مصدر إلهام لي كشاعر. تعلمت أن أستفيد من كل تجربة وأحولها إلى مصدر قوة وإبداع.

إذا كنت ترغب في معرفة المزيد عن قصائدي وتجربتي في المنفى، فلا تتردد في طرح المزيد من الأسئلة وسأكون سعيداً للإجابة عليها.
  <</SYS>>
  """;

  final String url =
      "https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29";
  final String apiToken =
      "eyJraWQiOiIyMDI0MTEwMTA4NDIiLCJhbGciOiJSUzI1NiJ9.eyJpYW1faWQiOiJJQk1pZC02OTMwMDBGQ0NOIiwiaWQiOiJJQk1pZC02OTMwMDBGQ0NOIiwicmVhbG1pZCI6IklCTWlkIiwianRpIjoiYzYzZWNiMDctMDQ5ZC00MTAxLWExZmUtNjAzZmM4NTg2MzM4IiwiaWRlbnRpZmllciI6IjY5MzAwMEZDQ04iLCJnaXZlbl9uYW1lIjoiU2FsZW0iLCJmYW1pbHlfbmFtZSI6IkFsLUhhbWVkIiwibmFtZSI6IlNhbGVtIEFsLUhhbWVkIiwiZW1haWwiOiJzYWxlbTEyMzQ1NjM2MEBnbWFpbC5jb20iLCJzdWIiOiJzYWxlbTEyMzQ1NjM2MEBnbWFpbC5jb20iLCJhdXRobiI6eyJzdWIiOiJzYWxlbTEyMzQ1NjM2MEBnbWFpbC5jb20iLCJpYW1faWQiOiJJQk1pZC02OTMwMDBGQ0NOIiwibmFtZSI6IlNhbGVtIEFsLUhhbWVkIiwiZ2l2ZW5fbmFtZSI6IlNhbGVtIiwiZmFtaWx5X25hbWUiOiJBbC1IYW1lZCIsImVtYWlsIjoic2FsZW0xMjM0NTYzNjBAZ21haWwuY29tIn0sImFjY291bnQiOnsidmFsaWQiOnRydWUsImJzcyI6ImZkMWU3M2IxNjkxYjQ4MTg5NjNkZDRkYjlkZDNmNTFlIiwiaW1zX3VzZXJfaWQiOiIxMjY3NzUxMyIsImZyb3plbiI6dHJ1ZSwiaW1zIjoiMjc0NzkyNiJ9LCJpYXQiOjE3MzEwODE5ODcsImV4cCI6MTczMTA4NTU4NywiaXNzIjoiaHR0cHM6Ly9pYW0uY2xvdWQuaWJtLmNvbS9pZGVudGl0eSIsImdyYW50X3R5cGUiOiJ1cm46aWJtOnBhcmFtczpvYXV0aDpncmFudC10eXBlOmFwaWtleSIsInNjb3BlIjoiaWJtIG9wZW5pZCIsImNsaWVudF9pZCI6ImRlZmF1bHQiLCJhY3IiOjEsImFtciI6WyJwd2QiXX0.En-6Qwo4yEoUnYPLoIo3ehSgYYnPBdautRbEKMsvAsrVan21noGTY5eFKB6PZnbSGHNDdXYhKnEUogemBJpQ6PrnYNYo0ALwn3e1lJm9JUA86MZtw6Mm74Foqb7p6r2wrDrdbfMh9lAv_XO-C_s9kP2MCbqALCpTT-3Mjy21s8lcKBUjiltB6hV9h5bM7JrzSMoXQgu_b3WKveyvUWTgnWQ9hhrjenaZAluNtw8QoHvjo3QAB3WulK7qc5pmB9KIsRFLekExUycynsEKjefSxSMVWdAoolRI5lRYD2pyBbypVGIeUhMiuq3HiDUvQ3Yar82oj33YeSryAdkJycnhxQ";
  Future<void> sendMessage(String message) async {
    String character = detectCharacter(message);
    messages.add({'sender': 'user', 'text': message, 'character': character});

    var body = {
      "input": "<s> [INST] $systemPrompt $message [/INST]",
      "parameters": {
        "decoding_method": "greedy",
        "max_new_tokens": 900,
        "repetition_penalty": 1.0,
      },
      "model_id": "sdaia/allam-1-13b-instruct",
      "project_id": "f3efb0ac-27ab-413a-827a-de0712ca03e1",
    };

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiToken",
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data != null &&
            data is Map &&
            data.containsKey('results') &&
            data['results'] is List &&
            data['results'].isNotEmpty &&
            data['results'][0].containsKey('generated_text')) {
          String reply = data['results'][0]['generated_text'];
          messages
              .add({'sender': 'bot', 'text': reply, 'character': character});
        } else {
          messages.add(
              {'sender': 'bot', 'text': "No valid response text from server"});
        }
      } else {
        messages.add({
          'sender': 'bot',
          'text':
              "Error: ${response.reasonPhrase} (Status Code: ${response.statusCode})"
        });
      }
    } catch (error) {
      messages.add({'sender': 'bot', 'text': "Failed to connect to server"});
    }

    textController.clear();
  }

  // Method to detect character based on message content
  String detectCharacter(String message) {
    if (message.contains("ابن سينا")) return "ابن سينا";
    if (message.contains("الخوارزمي")) return "الخوارزمي";
    if (message.contains("جابر بن حيان")) return "جابر بن حيان";
    if (message.contains("المتنبي")) return "المتنبي";
    if (message.contains("ابن الهيثم")) return "ابن الهيثم";
    if (message.contains("احمد شوقي")) return "احمد شوقي";
    return "default";
  }

  // Method to get character image
  String getCharacterImage(String character) {
    switch (character) {
      case "ابن سينا":
        return 'assets/images/jaber.webp';
      case "الخوارزمي":
        return 'assets/images/algebra.webp';
      case "جابر بن حيان":
        return 'assets/images/jabr.webp';
      case "المتنبي":
        return 'assets/images/motanmy.webp';
      case "ابن الهيثم":
        return 'assets/images/algebra.webp';
      case "احمد شوقي":
        return 'assets/images/man3.webp';
      default:
        return 'assets/images/men1.webp';
    }
  }
}

class ChipButton extends StatelessWidget {
  final String text;

  ChipButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<ChatController>().sendMessage(text);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Color(0xFF273470)),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
