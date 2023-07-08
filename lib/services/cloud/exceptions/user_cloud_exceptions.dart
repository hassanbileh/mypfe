class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateUserException extends CloudStorageException {}

class CloudNotGetAllUsersException extends CloudStorageException {}

class CouldNotGetUserNameException extends CloudStorageException{}

class CouldNotUpdateUserException extends CloudStorageException {}

class CouldNotDeleteUserException extends CloudStorageException {}

class CouldNotFindUser extends CloudStorageException {}

class CouldNotFindRoleException extends CloudStorageException {}

class CouldNotUpdateVerificationEmailException extends CloudStorageException {}

class CouldNotCreateStationException extends CloudStorageException {}

class CouldNotUpdateStationException extends CloudStorageException {}

class CouldNotDeleteStationException extends CloudStorageException {}

class CouldNotGetStationException extends CloudStorageException {}

class CouldNotCreateTrainException extends CloudStorageException {}

class CouldNotUpdateTrainException extends CloudStorageException {}

class CouldNotDeleteTrainException extends CloudStorageException {}

class CouldNotReadTrainException extends CloudStorageException {}

class CouldNotCreateClasseException extends CloudStorageException {}

class CouldNotUpdateClasseException extends CloudStorageException {}

class CouldNotDeleteClasseException extends CloudStorageException {}

class CouldNotReadClasseException extends CloudStorageException {}

class CouldNotCreateTicketException extends CloudStorageException {}

class CouldNotUpdateTicketException extends CloudStorageException {}

class CouldNotDeleteTicketException extends CloudStorageException {}

class CouldNotReadTicketException extends CloudStorageException {}

class CouldNotGetTrainsException extends CloudStorageException {}

class CouldNotCreateBookingException extends CloudStorageException {}

class CouldNotUpdateBookingException extends CloudStorageException {}

class CouldNotDeleteBookingException extends CloudStorageException {}

class CouldNotReadBookingException extends CloudStorageException {}

class CouldNotCreatePassengerException extends CloudStorageException {}

class CouldNotUpdatePassengerException extends CloudStorageException {}

class CouldNotDeletePassengerException extends CloudStorageException {}

class CouldNotReadPassengerException extends CloudStorageException {}