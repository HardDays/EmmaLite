import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/settings/settings_item.dart';
import 'package:emma_mobile/ui/screens/settings/about_text_screen.dart';
import 'package:emma_mobile/ui/screens/settings/feedback_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  final Function onTap;

  const AboutAppScreen({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmmaAppBar(
          title: 'Синхронизация',
          leading: BackLeading(
            text: 'Настройки',
            onTap: onTap,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: SettingsItem(
            title: 'Обратная связь',
            icon: AppIcons.message(),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => FeedbackScreen()),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: SettingsItem(
            title: 'Условия и положения',
            icon: AppIcons.documents(),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AboutTextScreen(
                    title: 'Условия и положения',
                    text:
                        'Мы не используем ваши персональные данные и не передаем их третьим лицам.  И еще много много юридичского текста.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consequat turpis vitae ullamcorper rutrum. Duis fermentum nisl at ante auctor, nec convallis risus pretium. Fusce diam lacus, aliquam nec orci auctor, scelerisque volutpat risus. Sed gravida sit amet sem quis faucibus. Nam dignissim, nisi at lacinia commodo, lorem diam pellentesque felis, nec commodo sem purus at erat. Mauris at neque mattis enim tristique ornare. Mauris leo dolor, bibendum eu placerat vehicula, fringilla sit amet augue. Integer sollicitudin pulvinar ornare. Morbi at enim vel tortor suscipit maximus. In congue cursus consequat. Vivamus scelerisque, metus quis posuere ornare, velit ipsum viverra felis, vitae commodo sem sem et odio. Curabitur dignissim nec neque vel venenatis.Pellentesque ut nulla justo. Fusce egestas mauris non metus dignissim, et condimentum quam convallis. Nulla convallis sit amet arcu a bibendum. Nam tempor interdum turpis, non vestibulum dolor lobortis eu. Donec vitae lectus bibendum, convallis dui vitae, pellentesque nulla. Integer quis risus id diam fermentum malesuada quis quis tortor. Sed eget ligula metus. Proin efficitur dignissim libero, sit amet pulvinar nisi vehicula et. Suspendisse facilisis non enim a venenatis. Suspendisse et nibh purus.',
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: SettingsItem(
            title: 'Политика конфиденциальности',
            icon: AppIcons.privacy(),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AboutTextScreen(
                    title: 'Политика конфиденциальности',
                    text:
                    'Мы не используем ваши персональные данные и не передаем их третьим лицам.  И еще много много юридичского текста.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consequat turpis vitae ullamcorper rutrum. Duis fermentum nisl at ante auctor, nec convallis risus pretium. Fusce diam lacus, aliquam nec orci auctor, scelerisque volutpat risus. Sed gravida sit amet sem quis faucibus. Nam dignissim, nisi at lacinia commodo, lorem diam pellentesque felis, nec commodo sem purus at erat. Mauris at neque mattis enim tristique ornare. Mauris leo dolor, bibendum eu placerat vehicula, fringilla sit amet augue. Integer sollicitudin pulvinar ornare. Morbi at enim vel tortor suscipit maximus. In congue cursus consequat. Vivamus scelerisque, metus quis posuere ornare, velit ipsum viverra felis, vitae commodo sem sem et odio. Curabitur dignissim nec neque vel venenatis.Pellentesque ut nulla justo. Fusce egestas mauris non metus dignissim, et condimentum quam convallis. Nulla convallis sit amet arcu a bibendum. Nam tempor interdum turpis, non vestibulum dolor lobortis eu. Donec vitae lectus bibendum, convallis dui vitae, pellentesque nulla. Integer quis risus id diam fermentum malesuada quis quis tortor. Sed eget ligula metus. Proin efficitur dignissim libero, sit amet pulvinar nisi vehicula et. Suspendisse facilisis non enim a venenatis. Suspendisse et nibh purus.',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
