import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../themes/app_theme.dart';
import '../bloc/auth_bloc.dart';
import '../models/auth_tokens.dart';
import '../models/user.dart';

class AuthenticatedDashboard extends StatelessWidget {

  const AuthenticatedDashboard({
    super.key,
    required this.user,
    required this.tokens,
  });
  final User user;
  final AuthTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // User Profile Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withAlpha((0.8 * 255).toInt()),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha((0.3 * 255).toInt()),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.onPrimary.withAlpha(
                    (0.2 * 255).toInt(),
                  ),
                  child: user.profileImageUrl != null
                      ? ClipOval(
                          child: Image.network(
                            user.profileImageUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  LucideIcons.user,
                                  size: 40,
                                  color: AppColors.onPrimary,
                                ),
                          ),
                        )
                      : const Icon(
                          LucideIcons.user,
                          size: 40,
                          color: AppColors.onPrimary,
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onPrimary.withAlpha((0.8 * 255).toInt()),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Token Information
          Expanded(
            child: ListView(
              children: [
                _buildInfoCard(
                  'Access Token',
                  tokens.accessToken,
                  LucideIcons.key,
                  AppColors.success,
                  onTap: () => _copyToClipboard(context, tokens.accessToken),
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  'Refresh Token',
                  tokens.refreshToken,
                  LucideIcons.refreshCw,
                  AppColors.info,
                  onTap: () => _copyToClipboard(context, tokens.refreshToken),
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  'Token Expiry',
                  _formatDateTime(tokens.expiresAt),
                  LucideIcons.clock,
                  tokens.willExpireSoon
                      ? AppColors.warning
                      : AppColors.secondary,
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  'Token Status',
                  tokens.isExpired
                      ? 'Expired'
                      : tokens.willExpireSoon
                      ? 'Expires Soon'
                      : 'Valid',
                  LucideIcons.shield,
                  tokens.isExpired
                      ? AppColors.error
                      : tokens.willExpireSoon
                      ? AppColors.warning
                      : AppColors.success,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      const AuthTokenRefreshRequested(),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.info,
                    side: const BorderSide(color: AppColors.info),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(LucideIcons.refreshCw, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Refresh Token',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.info,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthLogoutRequested());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(LucideIcons.logOut, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withAlpha((0.08 * 255).toInt()),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha((0.1 * 255).toInt()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(LucideIcons.copy, color: AppColors.textHint, size: 16),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.isNegative) {
      return 'Expired ${_formatDuration(difference.abs())} ago';
    } else {
      return 'Expires in ${_formatDuration(difference)}';
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
