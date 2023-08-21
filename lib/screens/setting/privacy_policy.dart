import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utilities/constants.dart';
import '../../utilities/styles.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Privacy Policy",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Last Updated: April 27, 2023\n\nIntroduction\n\nWelcome to TooCool.io, a mobile app that gamifies cold exposure, created and operated by TooCool Technologies, Inc. (“TooCool,” “we,” “us,” or “our”). Your privacy is of paramount importance to us, and we are committed to protecting your personal information.\n\nThis Privacy Policy describes how we collect, use, disclose, and store your personal information when you access or use our mobile app (“App”) and any related services (collectively, the “Services”). By using the App or the Services, you agree to the terms of this Privacy Policy. If you do not agree with these terms, please do not use the App or Services.\n\nInformation We Collect\n\nWe collect the following types of information:\n\nA. Personal Information: When you register an account with us or participate in certain features of the Services, we may collect personal information such as your name, email address, username, password, and birthdate.\n\nB. Usage Information: We automatically collect information about your use of the Services, such as the features you interact with, the time you spend on the App, and the frequency of your visits.\n\nC. Device Information: We collect information about the device you use to access the Services, such as the device type, operating system, unique device identifiers, and IP address.\n\nD. Location Information: With your consent, we may collect information about your precise location using GPS, Wi-Fi, or other location-based technologies.\n\nE. Social Media Information: If you choose to connect your social media accounts to our Services, we may collect information from those accounts.\n\nHow We Use Your Information\n\nWe use your information for the following purposes:\n\nA. To provide, maintain, and improve the Services, including personalizing your experience and providing tailored content and recommendations.\n\nB. To communicate with you, such as sending you updates, promotions, and responding to your inquiries.\n\nC. To monitor and analyze usage and trends to improve the Services and develop new features.\n\nD. To detect, investigate, and prevent fraudulent transactions and other illegal activities and protect the rights and property of TooCool and our users.\n\nE. For any other purpose described at the time of collection or with your consent.\n\nSharing Your Information\n\nWe may share your information in the following circumstances:\n\nA. With third-party service providers who help us operate and improve the Services, such as hosting providers, analytics providers, and payment processors.\n\nB. With other users, if you choose to participate in public features of the Services or share your content through social media.\n\nC. In response to a legal request, such as a subpoena, court order, or government demand, if we believe disclosure is required or appropriate.\n\nD. In connection with a merger, acquisition, or sale of assets, subject to the acquiring party’s adherence to this Privacy Policy.\n\nE. With your consent or at your direction. \n\nData Retention and Security\n\nWe retain your information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law. We implement appropriate technical and organizational measures to protect your information from unauthorized access, disclosure, or destruction.\n\nYour Rights and Choices\n\nYou may access, correct, or delete your personal information by logging into your account or contacting us at mailto:privacy@toocool.io. You may also opt-out of receiving promotional communications from us by following the instructions in those communications.\n\nIf you are a resident of the European Economic Area or California, you may have additional rights under applicable data protection laws, such as the right to object to our processing of your personal information, the right to restrict our processing of your personal information, and the right to data portability. To exercise any of these rights, please contact us at mailto:support@toocool.io.\n\nChildren’s Privacy\n\nThe Services are not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If we learn that we have collected personal information from a child under 13, we will take steps to delete that information as soon as possible.\n\nInternational Data Transfers\n\nYour information may be transferred to, stored in, and processed in countries other than the country in which you reside, including the United States, where data protection laws may be different from those in your country. By using the Services, you consent to the transfer of your information to countries outside your country of residence.\n\nThird-Party Links\n\nThe Services may contain links to third-party websites or apps. This Privacy Policy does not apply to the information collected by those websites or apps, and we are not responsible for their privacy practices. We encourage you to review the privacy policies of any third-party websites or apps you visit.\n\nChanges to This Privacy Policy\n\nWe may update this Privacy Policy from time to time. If we make any material changes, we will notify you by email or through the Services, and we will update the “Last Updated” date at the top of this Privacy Policy. We encourage you to review this Privacy Policy periodically for any changes.\n\nContact Us\n\nIf you have any questions or concerns about this Privacy Policy, please contact us at:\n\nTooCool Technologies, Inc.\n\nAttn: Privacy Officer\n\nEmail: mailto:support@toocool.io\n\nBy using the Services, you acknowledge that you have read and understand this Privacy Policy, and you agree to the collection, use, and disclosure of your information as described here in.",
                style: textStyleBlackR.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
