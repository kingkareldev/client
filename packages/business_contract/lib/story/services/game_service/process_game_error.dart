enum ProcessGameError {
  /// Commands are not valid.
  hasInvalidCommands,

  // Command tried to move the robot out of the grid or to a non walkable cell.
  invalidMove,

  // Command tried to put mark to a full cell.
  invalidPutMark,

  // Command tried to grab mark from an empty cell.
  invalidGrabMark,

  // Commands exceeded a speed limit,
  // meaning that the program probably cycles infinitely.
  exceededSpeedLimit,
}
