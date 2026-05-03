import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello() {
    return { status: true, pod: process.env.HOSTNAME as any };
  }
}
