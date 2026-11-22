import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Themes/theme_cubit.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Core/widgets/LogOutDialog.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/Features/Home/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:sintir/Features/Home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeNavigationDrawer extends StatefulWidget {
  const HomeNavigationDrawer({super.key, required this.onPageChanged});

  final ValueChanged<int> onPageChanged;

  static const double width = 288;
  static const double collapsedWidth = 80;

  @override
  State<HomeNavigationDrawer> createState() => _HomeNavigationDrawerState();
}

class _HomeNavigationDrawerState extends State<HomeNavigationDrawer> {
  static const double _gutter = 16;
  static const double _railGutter = 12;
  static const double _railMaxWidth = 200;
  static const Duration _duration = Duration(milliseconds: 280);

  bool? _expanded;

  void _toggle(bool expanded) => setState(() => _expanded = !expanded);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final items = BottomNavBarEntity.toList();
    final currentIndex = context.select((BottomNavCubit c) => c.currentIndex);
    final expanded =
        _expanded ?? MediaQuery.sizeOf(context).width >= Breakpoints.large;

    return AnimatedContainer(
      duration: _duration,
      curve: Curves.easeOutCubic,
      width: expanded
          ? HomeNavigationDrawer.width
          : HomeNavigationDrawer.collapsedWidth,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: BorderDirectional(
          end: BorderSide(
            color: theme.colorScheme.onSurface.withValues(
              alpha: isDark ? .08 : .06,
            ),
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < _railMaxWidth;
          final gutter = compact ? _railGutter : _gutter;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(gutter, 12, gutter, 0),
                child: _DrawerToggleButton(
                  expanded: expanded,
                  compact: compact,
                  onPressed: () => _toggle(expanded),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(gutter, 8, gutter, 12),
                child: _DrawerUserHeader(compact: compact),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: gutter,
                    vertical: 8,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 6),
                  itemBuilder: (context, index) => _DrawerDestination(
                    entity: items[index],
                    isSelected: index == currentIndex,
                    compact: compact,
                    onTap: () {
                      if (index != currentIndex) widget.onPageChanged(index);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(gutter, 8, gutter, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(
                      height: 1,
                      color: theme.colorScheme.onSurface.withValues(alpha: .08),
                    ),
                    const SizedBox(height: 12),
                    _ThemeModeTile(compact: compact),
                    const SizedBox(height: 12),
                    _LogoutButton(compact: compact),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DrawerToggleButton extends StatelessWidget {
  const _DrawerToggleButton({
    required this.expanded,
    required this.compact,
    required this.onPressed,
  });

  final bool expanded;
  final bool compact;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return Align(
      alignment: compact ? Alignment.center : AlignmentDirectional.centerEnd,
      child: IconButton(
        onPressed: onPressed,
        tooltip: expanded
            ? localizations.closeButtonTooltip
            : localizations.openAppDrawerTooltip,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .7),
        icon: Icon(expanded ? Icons.menu_open_rounded : Icons.menu_rounded),
      ),
    );
  }
}

class _DrawerUserAvatar extends StatelessWidget {
  const _DrawerUserAvatar({required this.imageUrl, required this.size});

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primary.withValues(alpha: .45), width: 1.5),
      ),
      child: ClipOval(
        child: imageUrl.trim().isEmpty
            ? ColoredBox(
                color: primary.withValues(alpha: .1),
                child: Icon(Icons.person, color: primary),
              )
            : CustomCachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

class _DrawerUserHeader extends StatelessWidget {
  const _DrawerUserHeader({required this.compact});

  final bool compact;

  static const BorderRadius _radius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final textStyles = AppTextStyles(context);
        final primary = theme.colorScheme.primary;
        final user = getUserData();
        final name = '${user.firstName} ${user.lastName}'
            .trim()
            .split(RegExp(r'\s+'))
            .join(' ');
        final role = user.role == BackendEndpoints.teacherRole
            ? LocaleKeys.teacherRole
            : LocaleKeys.studentRole;

        if (compact) {
          return Tooltip(
            message: name,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () =>
                      context.read<BottomNavCubit>().navigateToProfile(),
                  child: _DrawerUserAvatar(
                    imageUrl: user.profilePicurl,
                    size: 44,
                  ),
                ),
              ),
            ),
          );
        }

        return Material(
          color: primary.withValues(alpha: .06),
          borderRadius: _radius,
          child: InkWell(
            borderRadius: _radius,
            onTap: () => context.read<BottomNavCubit>().navigateToProfile(),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  _DrawerUserAvatar(imageUrl: user.profilePicurl, size: 56),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textStyles.bold16.copyWith(
                            color: theme.colorScheme.onSurface,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: primary.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: primary.withValues(alpha: .2),
                            ),
                          ),
                          child: Text(
                            role,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyles.semiBold12.copyWith(
                              color: primary,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DrawerDestination extends StatelessWidget {
  const _DrawerDestination({
    required this.entity,
    required this.isSelected,
    required this.compact,
    required this.onTap,
  });

  final BottomNavBarEntity entity;
  final bool isSelected;
  final bool compact;
  final VoidCallback onTap;

  static const double _iconSize = 24;
  static const BorderRadius _radius = BorderRadius.all(Radius.circular(16));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hsl = HSLColor.fromColor(KMainColor);
    final lightMain = hsl
        .withLightness((hsl.lightness + 0.08).clamp(0.0, 1.0))
        .toColor();
    final foreground = isSelected
        ? Colors.white
        : theme.colorScheme.onSurface.withValues(alpha: .7);
    final icon = SvgPicture.asset(
      isSelected ? entity.activeIcon : entity.inactiveIcon,
      width: _iconSize,
      height: _iconSize,
      colorFilter: ColorFilter.mode(foreground, BlendMode.srcIn),
    );

    final tile = Semantics(
      button: true,
      selected: isSelected,
      label: compact ? entity.title : null,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: _radius,
          hoverColor: KMainColor.withValues(alpha: .06),
          splashColor: KMainColor.withValues(alpha: .12),
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            height: compact ? 48 : 52,
            padding: EdgeInsets.symmetric(horizontal: compact ? 0 : 16),
            decoration: BoxDecoration(
              borderRadius: _radius,
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [lightMain, KMainColor],
                    )
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: KMainColor.withValues(alpha: .28),
                        blurRadius: 10,
                        spreadRadius: -1,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: compact
                ? Center(child: icon)
                : Row(
                    children: [
                      icon,
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          entity.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles(
                            context,
                          ).semiBold16.copyWith(color: foreground),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );

    return compact ? Tooltip(message: entity.title, child: tile) : tile;
  }
}

class _ThemeModeTile extends StatelessWidget {
  const _ThemeModeTile({required this.compact});

  final bool compact;

  static const BorderRadius _radius = BorderRadius.all(Radius.circular(16));

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (ThemeCubit cubit) => cubit.state == ThemeMode.dark,
    );
    final icon = Icon(
      isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
      size: 24,
      color: isDarkMode ? Colors.white : Colors.black,
    );

    if (compact) {
      return Center(
        child: IconButton(
          tooltip: LocaleKeys.darkMode,
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          icon: icon,
        ),
      );
    }

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: _radius,
        onTap: () => context.read<ThemeCubit>().toggleTheme(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 8, 4),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  LocaleKeys.darkMode,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context).semiBold16.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Switch(
                activeThumbColor: KMainColor,
                value: isDarkMode,
                onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.compact});

  final bool compact;

  static const BorderRadius _radius = BorderRadius.all(Radius.circular(16));

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(context: context, builder: (_) => const LogoutDialog());
  }

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Center(
        child: IconButton(
          tooltip: LocaleKeys.logout,
          onPressed: () => _showLogoutDialog(context),
          style: IconButton.styleFrom(
            fixedSize: const Size(48, 48),
            backgroundColor: Colors.red.withValues(alpha: .08),
            side: BorderSide(color: Colors.red.withValues(alpha: .25)),
            shape: const RoundedRectangleBorder(borderRadius: _radius),
          ),
          icon: const Icon(
            Icons.logout_rounded,
            color: Colors.redAccent,
            size: 20,
          ),
        ),
      );
    }

    return SizedBox(
      height: 48,
      child: Material(
        color: Colors.red.withValues(alpha: .08),
        shape: RoundedRectangleBorder(
          borderRadius: _radius,
          side: BorderSide(color: Colors.red.withValues(alpha: .25)),
        ),
        child: InkWell(
          borderRadius: _radius,
          onTap: () => _showLogoutDialog(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout_rounded,
                color: Colors.redAccent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  LocaleKeys.logout,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(
                    context,
                  ).semiBold16.copyWith(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
