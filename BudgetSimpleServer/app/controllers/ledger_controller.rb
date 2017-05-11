class LedgerController < ApplicationController
  def list
    render(
      json: {
        transactions: [
          { description: 'Overcooked',         category: 'doodad', transaction_at: (DateTime.now - 5).to_date },
          { description: 'Outlast',            category: 'doodad', transaction_at: (DateTime.now - 6).to_date },
          { description: 'Nier: Automata',     category: 'doodad', transaction_at: (DateTime.now - 7).to_date },
          { description: 'Spelunky',           category: 'doodad', transaction_at: (DateTime.now - 8).to_date },
          { description: 'Hyperlight Drifter', category: 'doodad', transaction_at: (DateTime.now - 1).to_date },
          { description: 'The Guradian',       category: 'doodad', transaction_at: (DateTime.now - 2).to_date },
          { description: 'Nier: Automata',     category: 'doodad', transaction_at: (DateTime.now - 3).to_date },
          { description: 'Spelunky',           category: 'doodad', transaction_at: (DateTime.now - 4).to_date }
        ]
      }
    )
  end
end
