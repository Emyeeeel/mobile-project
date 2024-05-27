import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePin {
  final PlatformFile? image;
  final String? title;
  final String? description;
  final String? board;

  CreatePin({
    required this.image,
    required this.title,
    required this.description,
    required this.board,
  });

  CreatePin copyWith({
    PlatformFile? image,
    String? title,
    String? description,
    String? board,
  }) {
    return CreatePin(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      board: board ?? this.board,
    );
  }
}

final pinProvider = StateNotifierProvider<PinNotifier, CreatePin>((ref) {
  return PinNotifier(
    CreatePin(
      image: null,
      title: '',
      description: '',
      board: '',
    ),
  );
});

class PinNotifier extends StateNotifier<CreatePin> {
  PinNotifier(CreatePin state) : super(state);

  void setImage(PlatformFile image) {
    state = state.copyWith(image: image);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setBoard(String board) {
    state = state.copyWith(board: board);
  }
}