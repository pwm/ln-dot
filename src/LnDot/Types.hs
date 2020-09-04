module LnDot.Types where

import Data.Aeson.Types (FromJSON, ToJSON)
import Data.Generics.Labels ()
import Data.Generics.Product ()
import qualified Data.GraphViz as GViz
import Data.Text (Text)
import GHC.Generics
import Prelude

----

data LnGraph = MkLnGraph
  { nodes :: [LnNode],
    edges :: [LnEdge]
  }
  deriving stock (Eq, Ord, Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

data LnNode = MkLnNode
  { pub_key :: PubKey,
    alias :: Alias
  }
  deriving stock (Eq, Ord, Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

data LnEdge = MkLnEdge
  { channel_id :: ChannelId,
    node1_pub :: PubKey,
    node2_pub :: PubKey
  }
  deriving stock (Eq, Ord, Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

newtype PubKey = MkPubKey Text
  deriving stock (Eq, Ord, Show, Generic)
  deriving (GViz.PrintDot) via Text
  deriving anyclass (FromJSON, ToJSON)

newtype Alias = MkAlias Text
  deriving stock (Eq, Ord, Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

newtype ChannelId = MkChannelId Text
  deriving stock (Eq, Ord, Show, Generic)
  deriving anyclass (FromJSON, ToJSON)
