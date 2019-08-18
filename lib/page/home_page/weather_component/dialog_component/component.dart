import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class DialogComponent extends Component<DialogState> {
  DialogComponent()
      : super(
          effect: buildEffect(),
          view: buildView,
        );
}
