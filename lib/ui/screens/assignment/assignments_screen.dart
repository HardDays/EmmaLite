import 'package:flutter/material.dart';

class AssignmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return BlocBuilder<AssignmentCubit, AssignmentState>(
    //   builder: (context, state) {
    //     return Scaffold(
    //       appBar: EmmaAppBarWithBottom(
    //         titleText: 'Назначения',
    //         //todo
    //         // bottomWidget: state.assignChipTypes != null
    //         //     ? _buildTypeChipList(context, state.assignChipTypes)
    //         //     : Container(),
    //       ),
    //       body: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         child: _buildBody(context),
    //       ),
    //     );
    //   },
    // );
  }

// Widget _buildBody(BuildContext context) {
//   //todo
//   // if (context
//   //         .watch<AssignmentCubit>()
//   //         .state
//   //         .assignmentList
//   //         ?.payload
//   //         ?.isNotEmpty ==
//   //     true) {
//   //   return Container();
//   // }
//   return const EmptyAssignments();
// }
//
// Widget _buildTypeChipList(BuildContext context, Iterable<String> items) {
//   return SizedBox(
//     height: 50,
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: List.generate(
//         items.length,
//         (index) => GestureDetector(
//           onTap: () => context.read<AssignmentCubit>(),
//           child: AssignmentTypeChip(
//             assignmentType: items.elementAt(index),
//             isActive: false,
//             //todo
//             // isActive: items.elementAt(index) ==
//             //     context.watch<AssignmentCubit>().state.currentTypeChip,
//           ),
//         ),
//       ),
//     ),
//   );
// }
}
