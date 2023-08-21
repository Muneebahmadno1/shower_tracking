import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utilities/constants.dart';
import '../../utilities/styles.dart';

class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
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
          "Terms & Conditions",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Last Updated: April 27, 2023\n\nIntroduction\n\nThese Terms and Conditions (“Terms”) govern your access to and use of the TooCool.io mobile application (“App”) and any related services (collectively, the “Services”) provided by TooCool Technologies, Inc. (“TooCool,” “we,” “us,” or “our”). By accessing or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, you may not access or use the App.\n\nEligibility\n\nTo use the Services, you must be at least 13 years of age. By accessing or using the Services, you represent and warrant that you meet this age requirement.\n\nLicense to Use the Services\n\nSubject to your compliance with these Terms, we grant you a limited, non-exclusive, non-transferable, non-sublicensable, revocable license to access and use the Services for your personal, non-commercial use.\n\nUser Content\n\nYou are responsible for any content, such as text, images, or other material, that you submit, post, or share through the Services (“User Content”). By submitting, posting, or sharing User Content, you grant us a worldwide, royalty-free, perpetual, irrevocable, non-exclusive, sublicensable, and transferable license to use, reproduce, distribute, prepare derivative works of, display, and perform the User Content in connection with the Services and our business.\n\nProhibited Conduct\n\nYou agree not to engage in any of the following prohibited activities:\n\nA. Using the Services for any purpose that is unlawful or prohibited by these Terms.\n\nB. Interfering with the operation of the Services or the servers or networks used to provide the Services.\n\nC. Decompiling, reverse engineering, or disassembling the App or attempting to derive its source code.\n\nD. Violating or infringing the rights of others, including intellectual property rights, privacy rights, or publicity rights.\n\nE. Submitting, posting, or sharing any User Content that is offensive, harmful, or otherwise objectionable.\n\nApp Leaderboards and Prizes\n\nA. The Services may include leaderboards that rank users based on their performance in the App. By participating in the leaderboard competitions, you agree to abide by these Terms and any additional rules we maynestablish.n\n\nB. We may, at our sole discretion, award prizes to the winners of leaderboard competitions. Each user is eligible to win only once, regardless of the number of leaderboards they participate in or the number of times they reach the top.n\n\nC. We reserve the right to determine the type, value, and eligibility requirements for any prizes awarded. We are not responsible for any taxes, fees, or other costs associated with the receipt or use of any prizes.n\n\nDisclaimers\n\nThe Services are provided on an “as is” and“as available” basis, without any warranties of any kind, either express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement. We do not warrant that the Services will be uninterrupted, error-free, or completely secure.\n\nLimitation of Liability\n\nTo the fullest extent permitted by law, in no event shall TooCool, its affiliates, or their respective officers, directors, employees, or agents be liable for any damages, including but not limited to direct, indirect, incidental, special, consequential, or punitive damages, arising out of or in connection with your access to or use of the Services or your inability to access or use the Services.\n\nIndemnification\n\nYou agree to indemnify, defend, and hold harmless TooCool, its affiliates, and their respective officers, directors, employees, and agents from and against any claims, liabilities, damages, losses, or expenses, including reasonable attorneys’ fees and costs, arising out of or in any way connected with your access to or use of the Services, your User Content, or your violation of these Terms.\n\nChanges to the Terms\n\nWe may update these Terms from time to time. If we make any material changes, we will notify you by email or through the Services, and we will update the “Last Updated” date at the top of these Terms. Your continued use of the Services following any changes to the Terms constitutes your acceptance of those changes.\n\nTermination\n\nWe reserve the right to terminate or suspend your access to or use of the Services, without notice, for any reason or no reason, including but not limited to your violation of these Terms. Upon termination, all licenses and other rights granted to you under these Terms will immediately cease.\n\nGoverning Law and Dispute Resolution\n\nThese Terms shall be governed by and construed in accordance with the laws of the State of [State], United States, without regard to its conflict of laws provisions. Any disputes arising out of or relating to these Terms or the Services shall be resolved exclusively through final and binding arbitration under the rules of the American Arbitration Association. The arbitration shall be conducted in the State of [State], United States, and judgment on the award rendered by the arbitrator(s) may be entered in any court having jurisdiction thereof.\n\nMiscellaneous\n\nThese Terms, along with our Privacy Policy, constitute the entire agreement between you and TooCool regarding your access to and use of the Services and supersede any prior agreements, whether written or oral, relating to the same subject matter. If any provision of these Terms is found to be invalid or unenforceable, that provision shall be deemed severable from these Terms and shall not affect the validity and enforceability of the remaining provisions.\n\nContact Us\n\nIf you have any questions or concerns about these Terms, please contact us at:\n\nTooCool Technologies, Inc.\n\nEmail: support@toocool.io\n\nBy using the Services, you acknowledge that you have read and understand these Terms and Conditions, and you agree to be bound by them.",
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
