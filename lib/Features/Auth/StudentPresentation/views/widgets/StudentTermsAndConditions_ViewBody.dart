// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class StudentTermsAndConditions_ViewBody extends StatelessWidget {
  const StudentTermsAndConditions_ViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text('١. المقدمة', style: AppTextStyles.bold19Auto),
          SizedBox(height: 8),
          Text(
            'باستخدام تطبيق سينتير، يوافق الطلاب على الالتزام بالشروط والأحكام التالية. تحكم هذه الشروط استخدام المنصة، بما في ذلك جميع التفاعلات مع المعلمين والطلاب الآخرين.',
          ),
          SizedBox(height: 16),
          Text('٢. إرشادات الاستخدام', style: AppTextStyles.bold19Auto),
          SizedBox(height: 8),
          Text(
            'يجب على الطلاب استخدام التطبيق لأغراض تعليمية فقط. أي سلوك غير لائق، مثل التحرش أو مشاركة محتوى غير قانوني أو تعطيل بيئة التعلم، سيؤدي إلى تعليق الحساب.',
          ),
          SizedBox(height: 16),
          Text('٣. المدفوعات والاسترداد', style: AppTextStyles.bold19Auto),
          SizedBox(height: 8),
          Text(
            'المدفوعات الخاصة بالدورات غير قابلة للاسترداد، باستثناء الحالات التي يتم فيها إلغاء الدورة من قبل المعلم. يجب على الطلاب التأكد من تلبية جميع متطلبات الدورة قبل التسجيل.',
          ),
          SizedBox(height: 16),
          Text('٤. سياسة الخصوصية', style: AppTextStyles.bold19Auto),
          SizedBox(height: 8),
          Text(
            'يحترم تطبيق سينتير خصوصيتك ويلتزم بحماية بياناتك الشخصية. يرجى الرجوع إلى سياسة الخصوصية الخاصة بنا لمعرفة المزيد حول كيفية جمع واستخدام وحماية معلوماتك.',
          ),
          SizedBox(height: 16),
          Text('٥. التغييرات في الشروط', style: AppTextStyles.bold19Auto),
          SizedBox(height: 8),
          Text(
            'يحتفظ تطبيق سينتير بالحق في تعديل هذه الشروط في أي وقت. سيتم إخطار الطلاب بأي تغييرات، واستخدام التطبيق بعد التغييرات يعني قبول الشروط الجديدة.',
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
