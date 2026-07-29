import 'package:equatable/equatable.dart';
import 'package:flowery/features/chat_bot/data/models/chat_message.dart';
import 'package:flowery/features/chat_bot/data/models/chat_model.dart';

class ChatBotState extends Equatable {
  final bool isWelcome;
  final String? firstName;
  final String? imageUrl;
  final List<ChatModel>? chats;
  final int selectedChatIndex;

  const ChatBotState({
    this.isWelcome = true,
    this.selectedChatIndex = -1,
    this.firstName = "Ahmed",
    this.imageUrl =
        "https://img.magnific.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?semt=ais_test_b&w=740&q=80",
    this.chats = const [
      ChatModel(
        chatTitle: 'Weight Loss Plan',
        messages: [
          ChatMessage(
            isBot: true,
            content: "Hi! 👋 What's your main fitness goal?",
          ),
          ChatMessage(isBot: false, content: "I want to lose about 10 kg."),
          ChatMessage(
            isBot: true,
            content: "Great goal! How many days per week can you exercise?",
          ),
          ChatMessage(isBot: false, content: "Around 4 days."),
          ChatMessage(
            isBot: true,
            content:
                "Perfect. I recommend 4 strength workouts and 2–3 sessions of 30-minute walking each week.",
          ),
          ChatMessage(isBot: false, content: "What about my diet?"),
          ChatMessage(
            isBot: true,
            content:
                "Aim for a calorie deficit, eat plenty of protein, vegetables, and drink at least 2 litres of water daily.",
          ),
        ],
      ),

      ChatModel(
        chatTitle: 'Muscle Building',
        messages: [
          ChatMessage(
            isBot: true,
            content: "Welcome back! What would you like to work on today?",
          ),
          ChatMessage(isBot: false, content: "I want to build muscle."),
          ChatMessage(
            isBot: true,
            content: "Excellent! Are you training at a gym or at home?",
          ),
          ChatMessage(isBot: false, content: "At the gym."),
          ChatMessage(
            isBot: true,
            content:
                "Focus on compound exercises like squats, bench press, rows, and deadlifts. Progressively increase the weights over time.",
          ),
          ChatMessage(isBot: false, content: "How much protein should I eat?"),
          ChatMessage(
            isBot: true,
            content:
                "A good target is around 1.6–2.2 grams of protein per kilogram of body weight every day.",
          ),
        ],
      ),

      ChatModel(
        chatTitle: 'Healthy Eating',
        messages: [
          ChatMessage(
            isBot: true,
            content: "Hi! What can I help you with today?",
          ),
          ChatMessage(isBot: false, content: "Can you suggest healthy snacks?"),
          ChatMessage(
            isBot: true,
            content:
                "Of course! Greek yogurt, mixed nuts, boiled eggs, fruit, and cottage cheese are all excellent choices.",
          ),
          ChatMessage(isBot: false, content: "I usually get hungry at night."),
          ChatMessage(
            isBot: true,
            content:
                "Try having a protein-rich snack like yogurt or cottage cheese. It helps keep you full for longer.",
          ),
          ChatMessage(
            isBot: false,
            content: "Should I avoid carbs completely?",
          ),
          ChatMessage(
            isBot: true,
            content:
                "Not at all. Choose complex carbohydrates like oats, rice, potatoes, and whole grains, and eat appropriate portions based on your goals.",
          ),
        ],
      ),
    ],
  });

  ChatBotState copyWith({
    final bool? isWelcome,
    final String? firstName,
    final String? imageUrl,
    final List<ChatModel>? chats,
    final int? selectedChatIndex,
  }) => ChatBotState(
    isWelcome: isWelcome ?? this.isWelcome,
    firstName: firstName ?? this.firstName,
    imageUrl: imageUrl ?? this.imageUrl,
    chats: chats ?? this.chats,
    selectedChatIndex: selectedChatIndex ?? this.selectedChatIndex,
  );

  @override
  List<Object?> get props => [
    isWelcome,
    firstName,
    imageUrl,
    chats,
    selectedChatIndex,
  ];
}
