# defmodule ESpec.Json.Matchers.IncludeJsonSpec do
#   use ESpec
#
#   import ESpec.Json.Matchers, only: [include_json: 1]
#
#   describe "include_json" do
#     subject do: json
#
#     context "with valid JSON as the subject" do
#       context "with a JSON array as the subject" do
#         let :json do
#           """
#           [
#             {
#               "hello": "world",
#               "yay": "woo",
#               "high": "score"
#             },
#             {
#               "another": "object"
#             }
#           ]
#           """
#         end
#
#         context "with a JSON array as the other" do
#           let :other_json_array do
#             """
#             [
#               {
#                 "hello": "world",
#                 "yay": "woo",
#                 "high": "score"
#               }
#             ]
#             """
#           end
#
#           it do: should include_json(other_json_array)
#         end
#
#         context "with a JSON object as the other" do
#           let :other_json_object do
#             """
#             [
#               {
#                 "hello": "world",
#                 "yay": "woo",
#                 "high": "score"
#               }
#             ]
#             """
#           end
#
#           it do: should include_json(other_json_object)
#         end
#
#         context "with a JSON integer as the other" do
#           let :other_json_integer, do: "5"
#
#           it do: should_not include_json(other_json_integer)
#         end
#       end
#
#       context "with a JSON object as the subject" do
#         let :json do
#           """
#           {
#             "hello": "world",
#             "yay": "woo",
#             "high": "score"
#           }
#           """
#         end
#
#         context "with a JSON array as the other" do
#           let :other_json_array do
#             """
#             [
#               {
#                 "hello": "world",
#                 "yay": "woo",
#                 "high": "score"
#               }
#             ]
#             """
#           end
#
#           it do: should_not include_json(other_json_array)
#         end
#
#         context "with a JSON object as the other" do
#           context "when the other JSON object is the same" do
#             let :other_json_object do
#               """
#               {
#                 "yay": "woo",
#                 "hello": "world",
#                 "high": "score"
#               }
#               """
#             end
#
#             it do: should include_json(other_json_object)
#           end
#
#           context "when the other JSON object contains more elements" do
#             let :other_json_object do
#               """
#               {
#                 "yay": "woo",
#                 "hello": "world",
#                 "high": "score",
#                 "woop": "woop"
#               }
#               """
#             end
#
#             it do: should_not include_json(other_json_object)
#           end
#
#           context "when the other JSON object contains fewer elements" do
#             let :other_json_object do
#               """
#               {
#                 "hello": "world",
#                 "high": "score"
#               }
#               """
#             end
#
#             it do: should include_json(other_json_object)
#           end
#         end
#
#         context "with a JSON integer as the other" do
#           let :other_json_integer, do: "5"
#
#           it do: should_not include_json(other_json_integer)
#         end
#       end
#     end
#   end
# end
