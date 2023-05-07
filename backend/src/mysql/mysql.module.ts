import { MySqlService } from './mysql.service';
import { Module } from '@nestjs/common';
import { MySqlController } from './mysql.controller';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
    imports: [
        TypeOrmModule.forRoot({
            type: 'mysql',
            host: '34.143.239.228',
            port: 3306,
            username: 'root',
            password: 'root',
            database: 'main_app',
            entities: [],
            synchronize: true,
        }),
    ],
    controllers: [MySqlController],
    providers: [MySqlService],
    exports: [MySqlService]
})
export class MySqlModule { }