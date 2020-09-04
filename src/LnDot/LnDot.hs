module LnDot.LnDot (printLnDot) where

import Control.Lens as Lens
import Control.Monad
import qualified Data.Aeson as Json
import qualified Data.Aeson.Types as Json
import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as BSL
import Data.Either.Combinators
import Data.Generics.Labels ()
import Data.Generics.Product ()
import Data.GraphViz (DotGraph)
import qualified Data.GraphViz as GViz
import qualified Data.Text.Lazy.IO as TL
import LnDot.Types
import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure)
import Prelude

----

printLnDot :: IO ()
printLnDot = do
  lnFile <-
    getArgs >>= \case
      [] -> do
        pn <- getProgName
        failWith $ "Usage: " <> pn <> " <ln-graph.json>"
      (fp : _) -> BSL.readFile fp
  case lnFileToDot lnFile of
    Left e -> failWith e
    Right vg -> TL.putStrLn $ GViz.printDotGraph vg
  where
    failWith msg = putStrLn msg >> exitFailure

----

lnFileToDot :: ByteString -> Either String (DotGraph PubKey)
lnFileToDot =
  mapRight toDotGraph . parseLnFile

parseLnFile :: ByteString -> Either String LnGraph
parseLnFile =
  Json.eitherDecode >=> Json.parseEither Json.parseJSON

toDotGraph :: LnGraph -> DotGraph PubKey
toDotGraph lng =
  GViz.graphElemsToDot
    GViz.nonClusteredParams
    (labelledNodeList lng)
    (labelledEdgeList lng)
  where
    labelledNodeList :: LnGraph -> [(PubKey, Alias)]
    labelledNodeList g = g ^.. #nodes . folded . Lens.to labelledNode
    labelledEdgeList :: LnGraph -> [(PubKey, PubKey, ChannelId)]
    labelledEdgeList g = g ^.. #edges . folded . Lens.to labelledEdge
    labelledNode :: LnNode -> (PubKey, Alias)
    labelledNode n = (n ^. #pub_key, n ^. #alias)
    labelledEdge :: LnEdge -> (PubKey, PubKey, ChannelId)
    labelledEdge e = (e ^. #node1_pub, e ^. #node2_pub, e ^. #channel_id)
