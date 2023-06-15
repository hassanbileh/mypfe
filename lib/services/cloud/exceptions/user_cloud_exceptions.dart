class CloudStorageException implements Exception{
  const CloudStorageException();
}

class CouldNotCreateUserException extends CloudStorageException{}

class CloudNotGetAllUsersException extends CloudStorageException{}

class CouldNotUpdateUserException extends CloudStorageException{}

class CouldNotDeleteUserException extends CloudStorageException{}

class CouldNotFindUser extends CloudStorageException{}

class CouldNotFindRoleException extends CloudStorageException{}

class CouldNotUpdateVerificationEmailException extends CloudStorageException{}
