import 'package:absence_manager_app/feature/absence_manager/data/remote/data_sources/absence_manager_remote_data_source.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_absence_list_usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_user_list_usecase.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<FetchAbsenceListUseCase>(),
  MockSpec<FetchUserListUseCase>(),
  MockSpec<AbsenceManagerRepository>(),
  MockSpec<AbsenceManagerRemoteDataSource>(),
])
void main() {}
