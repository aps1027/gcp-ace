import { join } from 'path';
import { AUTH_PACKAGE_NAME } from 'protos/dist/auth';

export const AUTH_GRPC_OPTION = {
  package: AUTH_PACKAGE_NAME,
  protoPath: join(__dirname, '../../../protos/auth.proto'),
  loader: {
    keepCase: true,
    includeDirs: [__dirname, '../../../protos'],
  },
  channelOptions: {
    'grpc.keepalive_time_ms': 10000,
    'grpc.keepalive_timeout_ms': 5000,
    'grpc.max_reconnect_backoff_ms': 1000,
    'grpc.service_config': JSON.stringify({
      loadBalancingConfig: [{ round_robin: {} }],
    }),
  },
};
