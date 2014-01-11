# encoding: utf-8

module Mutant

  # Return a frozen set of symbols from string enumerable
  #
  # @param [Enumerable<String>]
  #
  # @return [Set<Symbol>]
  #
  # @api private
  #
  def self.symbolset(strings)
    strings.map(&:to_sym).to_set.freeze
  end
  private_class_method :symbolset

  # Set of nodes that cannot be on the LHS of an assignment
  NOT_ASSIGNABLE = symbolset %w(
    int float str dstr class module self
  )

  # Set of op-assign types
  OP_ASSIGN              = symbolset %w(or_asgn and_asgn op_asgn)
  # Set of node types that are not valid when emitted standalone
  NOT_STANDALONE         = symbolset %w( splat restarg block_pass)
  INDEX_OPERATORS        = symbolset %w([] []=)
  UNARY_METHOD_OPERATORS = symbolset %w(~@ +@ -@ !)

  # Operators ruby implementeds as methods
  METHOD_OPERATORS = symbolset %w(
    <=> === []= [] <= >= == !~ != =~ <<
    >> ** * % / | ^ & < > + - ~@ +@ -@ !
  )

  BINARY_METHOD_OPERATORS = (
    METHOD_OPERATORS - (INDEX_OPERATORS + UNARY_METHOD_OPERATORS)
  ).to_set.freeze

  OPERATOR_METHODS = (
    METHOD_OPERATORS + INDEX_OPERATORS + UNARY_METHOD_OPERATORS
  ).to_set.freeze

  # Nodes that are NOT handled by mutant.
  #
  # not - 1.8 only, mutant does not support 1.8
  #
  NODE_BLACKLIST = symbolset %w(not)

  # Nodes that are NOT generated by parser but used by mutant / unparser.
  NODE_EXTRA = symbolset %w(empty)

  NODE_TYPES = ((Parser::Meta::NODE_TYPES + NODE_EXTRA) - NODE_BLACKLIST).to_set.freeze

end # Mutant
