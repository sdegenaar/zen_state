import 'package:zen_state/zen_state.dart';
import '../services/network_service.dart';

class NetworkModule extends ZenModule {
  @override
  String get name => 'NetworkModule';

  @override
  List<ZenModule> get dependencies => const [];

  @override
  void register(ZenScope scope) {
    // Register network service if not already registered
    if (Zen.findDependency<NetworkService>(scope: scope) == null) {
      // Use putDependency for regular services that don't extend ZenController
      Zen.putDependency<NetworkService>(
          NetworkService(),
          scope: scope
      );

      if (ZenConfig.enableDebugLogs) {
        ZenLogger.logDebug('NetworkService registered in $name module');
      }
    }
  }

  @override
  void onInit(ZenScope scope) {
    super.onInit(scope);

    // Additional initialization if needed
    final networkService = Zen.findDependency<NetworkService>(scope: scope);
    if (networkService != null) {
      networkService.initialize();
    }

    if (ZenConfig.enableDebugLogs) {
      ZenLogger.logDebug('NetworkModule initialized');
    }
  }

  @override
  void onDispose(ZenScope scope) {
    // Perform any cleanup needed when the module is unloaded
    final networkService = Zen.findDependency<NetworkService>(scope: scope);
    if (networkService != null) {
      networkService.shutdown();
    }

    if (ZenConfig.enableDebugLogs) {
      ZenLogger.logDebug('NetworkModule disposed');
    }

    super.onDispose(scope);
  }
}