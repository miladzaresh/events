class RepositoryUrls {
  RepositoryUrls._();

  static String _baseUrl = 'http://localhost:3000';
  static String _login = '/user';
  static String _signup = '/user';
  static String _events = '/events';
  static String _bookmarks = '/bookmark';

  static String login(String username, String password) =>
      '$_baseUrl$_login?username=$username&&password=$password';
  static String signup='$_baseUrl$_signup';

  static String myEvents(String userId)=>'$_baseUrl$_events?user_id=$userId';
  static String getEventDetails(String eventId)=>'$_baseUrl$_events/$eventId';
  static String deleteEvents(String id)=>'$_baseUrl$_events/$id';
  static String editEvent(String id)=>'$_baseUrl$_events/$id';

  static String getEvents='$_baseUrl$_events';
  static String addEvent='$_baseUrl$_events';

  static String searchEvents(String title,String price)=>'$_baseUrl$_events?title_like=$title&&price_like=$price';
  static String searchBookmarks(String title,String price,String userId)=>'$_baseUrl$_bookmarks?title_like=$title&&price_like=$price&&user_id=$userId';
  static String searchMyEvents(String title,String price,String userId)=>'$_baseUrl$_events?title_like=$title&&price_like=$price&&user_id=$userId';

  static String bookmarkEvents(String userId)=>'$_baseUrl$_bookmarks?user_id=$userId';
  static String deleteBookmarkEvents(String bookmarkId)=>'$_baseUrl$_bookmarks/$bookmarkId';
  static String addBookmark='$_baseUrl$_bookmarks';
}
