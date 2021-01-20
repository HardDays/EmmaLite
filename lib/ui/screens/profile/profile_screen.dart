import 'package:cached_network_image/cached_network_image.dart';
import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/repositories/profile_local_repository.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/buttons/emma_flat_button.dart';
import 'package:emma_mobile/ui/components/pickers/gender_picker.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/components/textfields/emm_text_field.dart';
import 'package:emma_mobile/ui/components/textfields/simple_text_field.dart';
import 'package:emma_mobile/ui/components/textfields/textfield_block.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/date_utils.dart';
import 'package:emma_mobile/utils/string_utils.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          EmmaAppBar(
            title: 'Профиль',
          ),
          BlocProvider<ProfileCubit>(
            create: (context) =>
                ProfileCubit(ProfileLocalRepository())..fetchProfile(),
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (true) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const HSpace(24),
                _buildProfileImage(context, ''),
                const HSpace(16),
                const Text(
                  // ignore: lines_longer_than_80_chars
                  'Вы можете добавить свое фото. Оно будет отображаться только в отчете',
                  style: CustomTextStyles.introLogoSubtitle,
                  textAlign: TextAlign.center,
                ),
                const HSpace(24),
                const TextFieldBlock(
                  children: [
                    SimpleTextField(
                      labelText: 'Имя',
                    ),
                    SimpleTextField(labelText: 'Фамилия')
                  ],
                ),
                const HSpace(12),
                const GenderPicker(
                  onSubmit: print,
                ),
                const HSpace(12),
                TextFieldBlock(
                  children: [
                    EmmaTextField(
                      withPicker: true,
                      textEditingController: _date,
                      labelText: 'Дата рождения',
                      onTap: () => showCustomDatePicker(
                          context,
                          (date) => _date.text = formatDateToString(date),
                          'Дата рождения',
                          mode: CupertinoDatePickerMode.date),
                    ),
                    const SimpleTextField(labelText: 'Вес'),
                    const SimpleTextField(labelText: 'Рост')
                  ],
                ),
                const HSpace(12),
                EmmaTextField(labelText: 'Телефон', onSubmit: (text) {}),
                const HSpace(12),
                EmmaTextField(labelText: 'Email', onSubmit: (text) {}),
                const HSpace(20),
                EmmaFilledButton(
                    title: 'Сохранить и продолжить',
                    onTap: () => print('save')),
                const HSpace(20),
                EmmaFlatButton(
                  title: 'Сделаю позже',
                  onTap: () => navigatorPop(context),
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildProfileImage(BuildContext context, String imageUrl) {
    return Container(
      width: 132,
      height: 132,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cFFFFFF,
        border: Border.all(width: 4, color: AppColors.cFFFFFF),
        image: DecorationImage(
          image: isNullOrEmpty(imageUrl)
              ? const AssetImage('assets/images/empty_avatar.png')
              : CachedNetworkImageProvider(imageUrl),
        ),
      ),
    );
  }
}
