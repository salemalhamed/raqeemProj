# main.py
from flask import Flask, request, jsonify
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator  # مسار بديل للاستيراد
from ibm_watsonx_ai import LanguageModel
import json
import requests

app = Flask(__name__)

authenticator = Authenticator(api_key="fn4G2SUsbm5utTnix6Xj-p6-SSaKbz0MlUnh6oyl54fU")
language_model = LanguageModel(authenticator=authenticator, service_url="https://eu-de.ml.cloud.ibm.com")

# إعداد متغيرات مثل عنوان الـIBM API والمفتاح الشخصي
IBM_API_URL = "https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29"
IBM_API_KEY = "fn4G2SUsbm5utTnix6Xj-p6-SSaKbz0MlUnh6oyl54fU"  # ضع هنا المفتاح الشخصي

@app.route('/generate_text', methods=['POST'])
def generate_text():
    # استقبال بيانات JSON من الطلب
    input_data = request.json.get("input", "")

    # إعداد البيانات لإرسالها إلى IBM API
    body = {
        "input": input_data,
        "parameters": {
            "decoding_method": "greedy",
            "max_new_tokens": 900,
            "repetition_penalty": 1
        },
        "model_id": "sdaia/allam-1-13b-instruct",
        "project_id": "f3efb0ac-27ab-413a-827a-de0712ca03e1"
    }
    headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": f"Bearer {IBM_API_KEY}"
    }

    # إرسال الطلب إلى IBM API python main.py

    response = requests.post(IBM_API_URL, headers=headers, json=body)
    
    # التحقق من حالة الاستجابة
    if response.status_code != 200:
        return jsonify({"error": "Failed to generate text", "details": response.text}), response.status_code
    
    # إعادة النتيجة إلى العميل كتنسيق JSON
    data = response.json()
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)
