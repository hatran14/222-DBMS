import { MyCassandraService } from './mycassandra.service';
import { Module } from '@nestjs/common';
import { CassandraModule } from '@mich4l/nestjs-cassandra';
import { MyCassandraController } from './mycassandra.controller';

@Module({
    imports: [
        CassandraModule.forRoot({
            keyspace: 'store',
            contactPoints: ['127.0.0.1'],
            localDataCenter: 'datacenter1',
        }),
    ],
    controllers: [MyCassandraController],
    providers: [MyCassandraService],
    exports: [MyCassandraService]
})
export class MyCassandraModule { }