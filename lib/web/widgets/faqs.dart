import 'package:flutter/material.dart';
import 'package:yexah/web/const/color.dart';

import '../const/const.dart';
import '../screen/home_page.dart';
import 'dashboard.dart';
import 'deals_at_yexah_banner.dart';

class Faqs extends StatelessWidget {
  final bool isdarkk;
  const Faqs({super.key, required this.isdarkk});

  @override
  Widget build(BuildContext context) {
    bool isMobileView(BuildContext context) {
      return MediaQuery.of(context).size.width <
          600; // You can adjust this threshold
    }

    return Column(
      children: [
        Container(
          width: isMobileView(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.789,
          height: screenheight(context) * 0.85,
          color: isdarkk
              ? ColorConst.rightcontainerdark
              : ColorConst.rightcontainerlite,
          padding: EdgeInsets.all(screenwidth(context) * .01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: DealsAtYexahBanner(isdarkk: isdarkk, ctx: context),
                ),
                SizedBox(height: screenheight(context) * .05),
                Text(
                  'Deals At Yexah!',
                  style: TextStyle(
                    color: isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'I logged in, selected the product I need and I am ok with the price, now what  ? ',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        color:
                            isdark ? ColorConst.scaffoldDark : ColorConst.white,
                        child: ListTile(
                          title: Text(
                              'Once you click submit, you will be asked to furnish a few details of your business along with your company identification documents  (PAN/ GST number if in India ) and so on. You will receive an email on successfully uploading the documents. Our team will review the documents uploaded and once approved will share with you an agreement draft within 24 hours. Once you digitally sign the agreement, you will receive the countersigned agreement from our side aling with the custom API kit for integration within 2 business days. ',
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb,
                                  fontSize: isMobileView(context)
                                      ? 14
                                      : screenwidth(context) * 0.01)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'I got the API kit , but my team is unable to make the integration live on me website/ app ? ',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text(
                            'Please feel free to connect with us. Our tech team can work with your team to identify and troubleshoot issues. We typically respond to all tech support requests within the same business day.',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Pricing And Plans',
                  style: TextStyle(
                      color:
                          isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                      fontSize: isMobileView(context)
                          ? 14
                          : screenwidth(context) * 0.01,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'When do I start paying for my Yexah! Subscription ?',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text(
                            'The Yexah! Platform is free to use. Simply goto our “code samples” section and download the API docs to integrate with your payments page and track embedded third party revenues if you have any. We only charge you, when you use curated deals on our platform. Login to the Yexah! Platform to track partners, and active products/ service integrations in your region.  Do feel free to reach out to us if you need any assistance to integrate the platform with your interface. ',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'How much do I pay for accessing \n curated deals?',
                          style: TextStyle(
                              color: isdark
                                  ? ColorConst.textdarkw
                                  : ColorConst.textliteb,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobileView(context)
                                  ? 14
                                  : screenwidth(context) * 0.01),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        color:
                            isdark ? ColorConst.scaffoldDark : ColorConst.white,
                        child: ListTile(
                          title: Text(
                              'The product pricing depends on : the partner, product / service being integrated and the estimated volumes during the course of the year. We typically seek visibility of monthly/ annual volumes estimated to arrive at a custom pricing plan for you. Sign up and login to the Yexah! Platform to see live deals. Click on a deal to view the pricing calculator. Once you enter inputs based on your business; your customized pricing plan will get displayed.',
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb,
                                  fontSize: isMobileView(context)
                                      ? 14
                                      : screenwidth(context) * 0.01,
                                  fontFamily: 'Nunito')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Can I change my pricing plan ?',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text(
                            ' Yes, you can. In case you see higher volumes than anticipated; you can alter the inputs on the live products section to arrive at the revised pricing plan. However, volumes will be reconciled with actuals by our platform once every 3 months and our billings will reflect charges based on achieved volumes (not forecasted) . This is so because, we negotiate prices from our partners based on volumes and so are contractually bound to pay higher ourselves. ',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01,
                                fontFamily: 'Nunito')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Integration',
                  style: TextStyle(
                      color:
                          isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Can Yexah! sync with my existing CRM ?',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text(
                            'Yes ! The platform is specifically designed to access key revenue metrics from your website/ mobile app customer journey. The platform can be used as a standalone CRM exclusively for your platform driven business needs or it can be integrated with your existing CRM. Talk to us to know how.',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01,
                                fontFamily: 'Nunito')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Does Yexah! use a separate payment gateway ?',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text(
                            'No, we do not. You can use your existing payment gateways and all ancillary revenues from third party curated deals  accrue directly to you. We invoice you monthly based on our agreed pricing model. ',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01,
                                fontFamily: 'Nunito')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'About Yexah!',
                  style: TextStyle(
                      color:
                          isdark ? ColorConst.textdarkw : ColorConst.textliteb,
                      fontSize: isMobileView(context)
                          ? 14
                          : screenwidth(context) * 0.01,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(
                                'Who will I be working with specifically ? Will there be a relationship management team ?',
                                style: TextStyle(
                                    color: isdark
                                        ? ColorConst.textdarkw
                                        : ColorConst.textliteb,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobileView(context)
                                        ? 14
                                        : screenwidth(context) * 0.01))),
                      ],
                    ),
                    children: [
                      Container(
                        color:
                            isdark ? ColorConst.scaffoldDark : ColorConst.white,
                        child: ListTile(
                          title: Text(
                              'We understand that a new embedded solution may need some time to be seamlessly integrated. You will be assigned a dedicated POC at Yexah! as soon as you receive your custom API kit to start your journey. ',
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb,
                                  fontSize: isMobileView(context)
                                      ? 14
                                      : screenwidth(context) * 0.01,
                                  fontFamily: 'Nunito')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  color: isdark ? ColorConst.scaffoldDark : ColorConst.white,
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConst.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'How do you onboard partners for curated deals ? ',
                            style: TextStyle(
                                color: isdark
                                    ? ColorConst.textdarkw
                                    : ColorConst.textliteb,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobileView(context)
                                    ? 14
                                    : screenwidth(context) * 0.01),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        color:
                            isdark ? ColorConst.scaffoldDark : ColorConst.white,
                        child: ListTile(
                          title: Text(
                              'We follow a rigorous vetting process for onboarding any partner. All our partner businesses are well capitalized and funded businesses with a prove track record of delivering quality products and services . We enter into binding agreements and SLAs with our partners at the onboarding stage which can be shared with you on request. ',
                              style: TextStyle(
                                  color: isdark
                                      ? ColorConst.textdarkw
                                      : ColorConst.textliteb,
                                  fontSize: isMobileView(context)
                                      ? 14
                                      : screenwidth(context) * 0.01)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const FooterCon()
      ],
    );
  }
}
