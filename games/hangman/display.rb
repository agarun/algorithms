module Display
  LIVES = {
    8 => <<~STATE_8,
                ________
                |      |
                       |
                       |
                       |
                       |
                       |
                       |
    .__________________|_.
    STATE_8
    7 => <<~STATE_7,
                ________
                |      |
                O      |
                       |
                       |
                       |
                       |
                       |
    .__________________|_.
    STATE_7
    6 => <<~STATE_6,
                ________
                |      |
                O      |
                |      |
                       |
                       |
                       |
                       |
    .__________________|_.
    STATE_6
    5 => <<~STATE_5,
                ________
                |      |
                O      |
                |      |
                |      |
                       |
                       |
                       |
    .__________________|_.
    STATE_5
    4 => <<~STATE_4,
                ________
                |      |
                O      |
                |      |
               /|      |
                       |
                       |
                       |
    .__________________|_.
    STATE_4
    3 => <<~STATE_3,
                ________
                |      |
                O      |
                |      |
               /|\\     |
                       |
                       |
                       |
    .__________________|_.
    STATE_3
    2 => <<~STATE_2,
                ________
                |      |
                O      |
                |      |
               /|\\     |
                |      |
                       |
                       |
    .__________________|_.
    STATE_2
    1 => <<~STATE_1,
                ________
                |      |
                O      |
    uhh...      |      |
               /|\\     |
                |      |
               /       |
                       |
    .__________________|_.
    STATE_1
    0 => <<~STATE_0
                ________
    one         |      |
    shot,       O      |
    one         |      |
    opportun-  /|\\     |
    ity...      |      |
               / \\     |
                       |
    .__________________|_.
    STATE_0
  }.freeze

  STARTING_LIVES = LIVES.size - 1
end
