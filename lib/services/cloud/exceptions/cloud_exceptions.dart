class CloudStorageException implements Exception{
  const CloudStorageException();
}

class CouldNotCreateNoteException extends CloudStorageException{}

class CloudNotGetAllNotesException extends CloudStorageException{}

class CouldNotUpdateNoteException extends CloudStorageException{}

class CouldNotDeleteNotException extends CloudStorageException{}

class CouldNotFindUser extends CloudStorageException{}

class CouldNotFindRoleException extends CloudStorageException{}

class CouldNotUpdateVerificationEmailException extends CloudStorageException{}
