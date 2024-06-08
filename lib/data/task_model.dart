class TaskModel{
   String title;
   bool isChecked;

  TaskModel({required this.title, required this.isChecked});

  void toggle(){
    isChecked = !isChecked;
  } 

   factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        isChecked: json["isChecked"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "isChecked": isChecked,
    };
}