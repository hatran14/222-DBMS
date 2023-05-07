import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MyCassandraModule } from './cassandra/mycassandra.module';
import { MySqlModule } from './mysql/mysql.module';

@Module({
  imports: [MyCassandraModule, MySqlModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
