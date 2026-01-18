{ userInfo, ... }:

{
  config = {
    # TODO: should be in sync :(
    userSettings = {
      name = userInfo.name;
      email = userInfo.email;
    };
  };

}
