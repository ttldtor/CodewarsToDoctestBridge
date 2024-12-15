// Copyright (c) 2024 ttldtor.
// SPDX-License-Identifier: BSL-1.0

#pragma once

#include <doctest/doctest.h>

#include <string>

namespace org::ttldtor {

#define Describe(Name) TEST_CASE(#Name)
#define It(Name) SUBCASE(#Name)

template <typename Data>
struct EqualsParam {
  const Data &data;
};

template <typename Data>
EqualsParam<Data> Equals(const Data &data) {
  return {data};
}

std::string ExtraMessage(std::string m) {
  return m;
}

struct Assert {
  template <typename ValueType, template <typename> typename OperatorType, typename DataType>
  static void That(ValueType &&value, OperatorType<DataType> &&op, const std::string &message);

  template <typename ValueType, typename OperatorType>
  static void That(ValueType &&value, OperatorType &&op);
};

template <typename ValueType, template <typename> typename OperatorType, typename DataType>
void Assert::That(ValueType &&value, OperatorType<DataType> &&op, const std::string &message) {
  if constexpr (std::is_same_v<std::decay_t<OperatorType<DataType>>, EqualsParam<DataType>>) {
    if (message.empty()) {
      CHECK_EQ(value, op.data);
    } else {
      CHECK_MESSAGE(value == op.data, message);
    }
  }
}

template <typename ValueType, typename OperatorType>
void Assert::That(ValueType &&value, OperatorType &&op) {
  That(std::forward<ValueType>(value), std::forward<OperatorType>(op), "");
}

}  // namespace org::ttldtor
