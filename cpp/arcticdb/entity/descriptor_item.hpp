/* Copyright 2023 Man Group Operations Limited
 *
 * Use of this software is governed by the Business Source License 1.1 included in the file licenses/BSL.txt.
 *
 * As of the Change Date specified in that file, in accordance with the Business Source License, use of this software will be governed by the Apache License, version 2.0.
 */

#pragma once

#include <arcticdb/entity/atom_key.hpp>
#include <fmt/format.h>
#include <string>


namespace arcticdb {
struct DescriptorItem {
    DescriptorItem(
        entity::AtomKey &&key, 
        std::optional<IndexValue> start_index, 
        std::optional<IndexValue> end_index,
        std::optional<google::protobuf::Any> timeseries_descriptor) :
        key_(std::move(key)),
        start_index_(start_index),
        end_index_(end_index),
        timeseries_descriptor_(timeseries_descriptor) {
    }

    DescriptorItem() = delete;

    entity::AtomKey key_;
    std::optional<IndexValue> start_index_;
    std::optional<IndexValue> end_index_;
    std::optional<google::protobuf::Any> timeseries_descriptor_;
    
    std::string symbol() const { return fmt::format("{}", key_.id()); }
    uint64_t version() const { return key_.version_id(); }
    timestamp creation_ts() const { return key_.creation_ts(); }
    std::optional<IndexValue> start_index() const { return start_index_; }
    std::optional<IndexValue> end_index() const { return end_index_; }
    std::optional<google::protobuf::Any> timeseries_descriptor() const { return timeseries_descriptor_; }
};
}