import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class PayoutTermsAndConditionsViewBody extends StatelessWidget {
  const PayoutTermsAndConditionsViewBody({super.key});

  Widget _buildSection(String title, String body, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: AppTextStyles(context).semiBold16,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.right,
            style: AppTextStyles(context).regular14,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Arabic Terms & Conditions text organized into clear sections
    const introTitle = 'مقدمة';
    const introBody =
        'تنظم هذه الشروط والأحكام عملية سحب الأرباح (Payout) للمدرسين داخل تطبيق "سينتير". '
        'بمجرد طلب السحب فأنت توافق على جميع البنود الواردة في هذه الصفحة.';

    const methodTitle = 'طريقة السحب';
    const methodBody =
        'تتم جميع عمليات السحب من خلال بوابة الدفع "Paymob". يجب إدخال بيانات السحب بشكل صحيح (مثل رقم الحساب أو رقم المحفظة). '
        'أي خطأ في البيانات قد يؤدي إلى تأخير أو إلغاء عملية التحويل.';

    const eligibilityTitle = 'معايير الأهلية';
    const eligibilityBody =
        'يحق لك طلب سحب الأرباح في حال تحقق الشروط التالية:\n'
        '1. إتمام التحقق من الحساب (KYC) إذا طُلب منك ذلك.\n'
        '2. وجود حساب مدرس نشط على منصة سينتير.\n'
        '3. أن تكون الأرباح ناتجة عن معاملات شرعية ومقبولة على المنصة.';

    const minimumTitle = 'الحد الأدنى للسحب';
    const minimumBody =
        'الحد الأدنى للسحب يتم تحديده وفقاً لسياسات بوابة الدفع Paymob وسياسات المنصة. '
        'الطلبات التي تقل عن الحد الأدنى لن تُعالج حتى يجمع الحساب الحد المطلوب.';

    const processingTitle = 'مدة معالجة الطلبات';
    const processingBody =
        'عادةً ما تستغرق عملية السحب من 2 إلى 5 أيام عمل بحسب سرعة Paymob والبنك أو موفر المحفظة. '
        'قد تحدث تأخيرات إضافية في أيام العطلات الرسمية أو عطلات نهاية الأسبوع.';

    const feesTitle = 'الرسوم والخصومات';
    const feesBody =
        '1. يتم خصم نسبة 5% من سعر كل عملية بيع كرسوم منصة قبل احتساب رصيدك القابل للسحب.\n'
        '2. قد تقوم Paymob أو البنك بخصم رسوم معالجة أو رسوم تحويل إضافية حسب طريقة السحب.\n'
        '3. أي رسوم بنكية دولية أو رسوم تحويل بين عملات يتحملها المستخدم عند ظهورها.';

    const updateInfoTitle = 'تحديث بيانات السحب';
    const updateInfoBody =
        'أنت مسؤول عن التأكد من صحة وتحديث بيانات السحب الخاصة بك. في حال تقديم بيانات خاطئة وتأخر أو ضياع التحويل، '
        'لن تكون منصة سينتير مسؤولة عن التعويض إلا إذا ثبت تقصير من طرفنا.';

    const refundsTitle = 'حالات الاسترجاع (Refund) والخصم';
    const refundsBody =
        'في حال طلب طالب استرجاع لمبلغ تم دفعه أو تم إلغاء عملية دفع، سيتم خصم المبلغ المسترجَع من رصيدك. '
        'إذا لم يكفِ الرصيد، سيتم خصم المبلغ من دفعاتك المستقبلية.';

    const fraudTitle = 'حالات الاحتيال والمراجعة';
    const fraudBody =
        'قد يتم إيقاف أو تجميد أو إلغاء أي عملية سحب إذا رصدت المنصة أو بوابة الدفع نشاطاً مشبوهاً أو احتيالياً. '
        'تحتفظ المنصة بالحق في تدقيق وتحليل العمليات وطلب مستندات إضافية لإتمام عملية السحب.';

    const supportTitle = 'الدعم والمساعدة';
    const supportBody =
        'لأية مشكلات متعلقة بالسحب: تواصل مع دعم سينتير أولاً عبر داخل التطبيق. '
        'لحالات التحويل الفني أو تأخر الدفع التي تتعلق ببوابة الدفع، قد يُطلب منك التواصل مع دعم Paymob وتقديم رقم العملية.';

    const acceptanceTitle = 'الموافقة';
    const acceptanceBody =
        'بطلبك للسحب، تؤكد موافقتك على جميع البنود المذكورة أعلاه. قد تقوم المنصة بتحديث هذه الشروط من وقت لآخر. '
        'في حال تم تعديل الشروط سيتم إعلامك وقد يُطلب منك إعادة الموافقة على النسخة الجديدة قبل إتمام عمليات السحب المستقبلية.';

    return Scrollbar(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 6),
            _buildSection(introTitle, introBody, context),
            _buildSection(methodTitle, methodBody, context),
            _buildSection(eligibilityTitle, eligibilityBody, context),
            _buildSection(minimumTitle, minimumBody, context),
            _buildSection(processingTitle, processingBody, context),
            _buildSection(feesTitle, feesBody, context),
            _buildSection(updateInfoTitle, updateInfoBody, context),
            _buildSection(refundsTitle, refundsBody, context),
            _buildSection(fraudTitle, fraudBody, context),
            _buildSection(supportTitle, supportBody, context),
            _buildSection(acceptanceTitle, acceptanceBody, context),
          ],
        ),
      ),
    );
  }
}
