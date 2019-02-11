class DateTimeConverter {
  static String getDurationAsText(DateTime time) {
    var now =  DateTime.now();
    var duration = now.difference(time);

    if(duration.inMinutes < 1){
      return "some seconds ago";
    }
    else if(duration.inMinutes < 60){
      if(duration.inMinutes==1) return '1 minute ago';
      return '${duration.inMinutes} minutes ago';
    }
    else if(duration.inHours < 24){
      if(duration.inHours==1) return '1 hour ago';
      return '${duration.inHours} hours ago';
    }
    else if(duration.inDays < 7){
      if(duration.inDays==1) return '1 day ago';
      return '${duration.inDays} days ago';
    }
    else if(duration.inDays < 28){
        var weeks = (duration.inDays/7).floor();
        if(weeks == 1) return '1 week ago';
        return '$weeks weeks ago';
    }
    else if(now.month == time.month){
      return '4 weeks ago';
    }
    else if(now.year == time.year && now.month-time.month < 12) {
      return '${(now.month - time.month).floor()} month ago';
    }
    else if(now.year != time.year && 12-(time.month- now.month) < 12)
      return '${12-(time.month- now.month)} month ago';
    else {
      if((now.year-time.year)==1) return '1 year ago';
      return '${(now.year - time.year).floor()} years ago';
    }
  }
}
