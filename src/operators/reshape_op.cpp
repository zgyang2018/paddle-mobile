/* Copyright (c) 2018 PaddlePaddle Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */

#ifdef RESHAPE_OP

#include "operators/reshape_op.h"
#include <vector>
namespace paddle_mobile {
namespace operators {

template <typename Dtype, typename T>
void ReshapeOp<Dtype, T>::InferShape() const {
  /// todo: add InputShape() detection.
  auto &shape = param_.Shape();
  auto input_x_dims = param_.InputX()->dims();
  auto out_dims = ValidateShape(shape, input_x_dims);
  param_.Out()->Resize(out_dims);
}
template class ReshapeOp<CPU, float>;
}  // namespace operators
}  // namespace paddle_mobile

namespace ops = paddle_mobile::operators;
USE_OP(reshape);
REGISTER_OPERATOR(reshape, ops::ReshapeOp);

#endif