class Chat {
  final String name, lastmessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastmessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    name: "Tom Hardy",
    lastmessage: "Hope you are doing well...",
    image: "assets/images/user_Tomhardy.jpg",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Cilian Murphy",
    lastmessage: "I am too old for that.",
    image: "assets/images/user_3.png",
    time: "25s ago",
    isActive: true,
  ),
  Chat(
    name: "Adrien Brody",
    lastmessage: "Thanks for the oscar",
    image: "assets/images/user_adrien.jpg",
    time: "1d ago",
    isActive: true,
  ),
  Chat(
    name: "",
    lastmessage: "",
    image: "assets/images/user_adrien.jpg",
    time: "",
    isActive: false,
  ),
  Chat(
    name: "",
    lastmessage: "",
    image: "assets/images/user_adrien.jpg",
    time: "",
    isActive: false,
  ),
  Chat(
    name: "",
    lastmessage: "",
    image: "assets/images/user_adrien.jpg",
    time: "",
    isActive: false,
  ),
  Chat(
    name: "",
    lastmessage: "",
    image: "assets/images/user_adrien.jpg",
    time: "",
    isActive: false,
  ),
  Chat(
    name: "",
    lastmessage: "",
    image: "assets/images/user_adrien.jpg",
    time: "",
    isActive: false,
  ),
];
