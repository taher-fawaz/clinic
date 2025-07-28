import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';

class TermsPrivacyScreen extends StatefulWidget {
  final bool showTerms;

  const TermsPrivacyScreen({
    super.key,
    this.showTerms = true,
  });

  @override
  State<TermsPrivacyScreen> createState() => _TermsPrivacyScreenState();
}

class _TermsPrivacyScreenState extends State<TermsPrivacyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.showTerms ? 0 : 1,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: ColorManager.backgroundPrimary,
        elevation: 0,
        title: Text(
          'profile.legal.title'.tr(),
          style: TextStyleManager.getBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorManager.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: ColorManager.primary,
          unselectedLabelColor: ColorManager.textSecondary,
          indicatorColor: ColorManager.primary,
          labelStyle: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s14,
          ),
          unselectedLabelStyle: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s14,
          ),
          tabs: [
            Tab(text: 'profile.legal.termsOfService'.tr()),
            Tab(text: 'profile.legal.privacyPolicy'.tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTermsOfService(),
          _buildPrivacyPolicy(),
        ],
      ),
    );
  }

  Widget _buildTermsOfService() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppPadding.p20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('profile.legal.terms.title'.tr()),
          _buildLastUpdated('profile.legal.terms.lastUpdated'.tr()),
          SizedBox(height: AppSize.s24.h),
          _buildSection(
            'profile.legal.terms.acceptance.title'.tr(),
            'profile.legal.terms.acceptance.content'.tr(),
          ),
          _buildSection(
            'profile.legal.terms.services.title'.tr(),
            'profile.legal.terms.services.content'.tr(),
          ),
          _buildSection(
            'profile.legal.terms.userAccount.title'.tr(),
            'profile.legal.terms.userAccount.content'.tr(),
          ),
          _buildSection(
            'profile.legal.terms.medicalInfo.title'.tr(),
            'profile.legal.terms.medicalInfo.content'.tr(),
          ),
          _buildSection(
            'profile.legal.terms.appointments.title'.tr(),
            'profile.legal.terms.appointments.content'.tr(),
          ),
          _buildSection(
            'profile.legal.terms.liability.title'.tr(),
            'profile.legal.terms.liability.content'.tr(),
          ),
          _buildSection(
            'profile.legal.terms.termination.title'.tr(),
            'profile.legal.terms.termination.content'.tr(),
          ),
          _buildSection(
            'profile.legal.terms.changes.title'.tr(),
            'profile.legal.terms.changes.content'.tr(),
          ),
          _buildSection(
            'profile.legal.terms.contact.title'.tr(),
            'profile.legal.terms.contact.content'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppPadding.p20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('profile.legal.privacy.title'.tr()),
          _buildLastUpdated('profile.legal.privacy.lastUpdated'.tr()),
          SizedBox(height: AppSize.s24.h),
          _buildSection(
            'profile.legal.privacy.introduction.title'.tr(),
            'profile.legal.privacy.introduction.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.dataCollection.title'.tr(),
            'profile.legal.privacy.dataCollection.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.dataUsage.title'.tr(),
            'profile.legal.privacy.dataUsage.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.dataSharing.title'.tr(),
            'profile.legal.privacy.dataSharing.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.dataSecurity.title'.tr(),
            'profile.legal.privacy.dataSecurity.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.userRights.title'.tr(),
            'profile.legal.privacy.userRights.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.cookies.title'.tr(),
            'profile.legal.privacy.cookies.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.thirdParty.title'.tr(),
            'profile.legal.privacy.thirdParty.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.children.title'.tr(),
            'profile.legal.privacy.children.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.changes.title'.tr(),
            'profile.legal.privacy.changes.content'.tr(),
          ),
          _buildSection(
            'profile.legal.privacy.contact.title'.tr(),
            'profile.legal.privacy.contact.content'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyleManager.getBoldStyle(
        fontSize: FontSize.s20,
        color: ColorManager.textPrimary,
      ),
    );
  }

  Widget _buildLastUpdated(String date) {
    return Container(
      margin: EdgeInsets.only(top: AppSize.s8.h),
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p12.w,
        vertical: AppPadding.p6.h,
      ),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      child: Text(
        date,
        style: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s12,
          color: ColorManager.textSecondary,
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.s20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: AppSize.s8.h),
          Text(
            content,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
