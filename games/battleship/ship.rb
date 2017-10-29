class Ship
  def self.ship_within_bounds?(board, position, ship_size)
    # placement of different ship types *horizontally* - check every spot that
    # will be occupied by the ship by fixing the `row` number (pos[0]) and cycling
    # through the `col` number (pos[1]). true if each spot is empty (`nil`)
    (position[1]...position[1] + ship_size).all? do |coord|
      return false if coord >= board.grid.size
      board.empty?([position[0], coord])
    end
  end

  def self.place_each_ship(board, ship_size, ship_symbol, player)
    coordinates = player.get_play
    coordinates = player.get_play until ship_within_bounds?(board, coordinates, ship_size)

    # TODO: vertical placement & checking
    (coordinates[1]...coordinates[1] + ship_size).each do |coord|
      position = [coordinates[0], coord]
      board[position] = ship_symbol
    end
  end
end
