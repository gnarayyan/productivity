// TODO: If you're sure developer enters as expected, just change for String
String parseAndValidateDataType(String dataType) {
  switch (dataType.trim().toLowerCase()) {
    // Return same
    case 'int':
      return 'int';
    case 'double':
      return 'double';

    // Return different
    case 'string':
      return 'String';

    case 'datetime':
      return 'DateTime';

    default:
      return 'String';
  }
}
